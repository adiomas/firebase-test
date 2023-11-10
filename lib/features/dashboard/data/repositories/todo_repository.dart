import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/common/constants/database_constants.dart';
import 'package:firebase_test/common/data/firestore/firestore_collections.dart';
import 'package:firebase_test/common/data/generic_error_resolver.dart';
import 'package:firebase_test/common/data/providers.dart';
import 'package:firebase_test/common/data/services/local_storage_service.dart';
import 'package:firebase_test/features/auth/domain/entities/login_type.dart';
import 'package:firebase_test/features/dashboard/domain/entities/todo.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

final todoRepositoryProvider = Provider<TodoRepository>(
  (ref) => TodoRepositoryImpl(
    ref.watch(localStorageServiceProvider),
    ref.watch(supabaseProvider),
  ),
);

abstract class TodoRepository {
  StreamFailureOr<List<Todo>> getTodos();
  EitherFailureOr<void> addTodo({
    required Todo todo,
  });
  EitherFailureOr<void> deleteTodo({
    required String id,
  });
  EitherFailureOr<void> toggleComplete({
    required String id,
    required bool isCompleted,
  });
}

class TodoRepositoryImpl with ErrorToFailureMixin implements TodoRepository {
  final LocalStorageService _localStorageService;
  final supabase.SupabaseClient _supabaseClient;

  final _todoRef = FirestoreCollections.todosCollection;

  TodoRepositoryImpl(this._localStorageService, this._supabaseClient);

  @override
  StreamFailureOr<List<Todo>> getTodos() async* {
    if (await _isFirebaseLogin()) {
      final userReference = FirebaseAuth.instance.currentUser?.uid;
      try {
        yield* FirestoreCollections.todosCollection
            .where(DatabaseConstants.userField, isEqualTo: userReference)
            .orderBy(DatabaseConstants.createdAtField, descending: true)
            .snapshots()
            .map(
              (snapshot) => Right(snapshot.docs.map((e) => e.data()).toList()),
            );
      } catch (e) {
        debugPrint('error: $e');
        yield Left(Failure.generic());
      }
    } else {
      final userReference = _supabaseClient.auth.currentUser?.id;
      try {
        yield* _supabaseClient
            .from(DatabaseConstants.todosCollection)
            .stream(primaryKey: ['id'])
            .eq(DatabaseConstants.userField, userReference)
            .order(DatabaseConstants.createdAtField, ascending: false)
            .map((event) {
              try {
                final list = event
                    .map(
                      (e) => Todo.fromJsonForSupabase(e),
                    )
                    .toList();
                return Right(list);
              } catch (e) {
                debugPrint('error: $e');
                return Left(Failure.generic());
              }
            });
      } catch (e) {
        yield Left(Failure.generic());
      }
    }
  }

  @override
  EitherFailureOr<void> addTodo({
    required Todo todo,
  }) =>
      execute(
        () async {
          if (await _isFirebaseLogin()) {
            final todoRef = _todoRef.doc(todo.id);
            final newTodo = todo.copyWith(id: todoRef.id);
            await todoRef.set(newTodo, SetOptions(merge: true));
          } else {
            await _supabaseClient
                .from(DatabaseConstants.todosCollection)
                .insert(todo.toJsonForSupabase());
          }
          return const Right(null);
        },
        errorResolver: const GenericErrorResolver(),
      );

  @override
  EitherFailureOr<void> toggleComplete(
          {required String id, required bool isCompleted}) =>
      execute(
        () async {
          if (await _isFirebaseLogin()) {
            await _todoRef.doc(id).update({
              DatabaseConstants.isCompletedField: isCompleted,
            });
          } else {
            await _supabaseClient
                .from(DatabaseConstants.todosCollection)
                .update({DatabaseConstants.isCompletedField: isCompleted}).eq(
              'id',
              int.parse(id),
            );
          }
          return const Right(null);
        },
        errorResolver: const GenericErrorResolver(),
      );

  @override
  EitherFailureOr<void> deleteTodo({required String id}) => execute(
        () async {
          if (await _isFirebaseLogin()) {
            await _todoRef.doc(id).delete();
          } else {
            await _supabaseClient
                .from(DatabaseConstants.todosCollection)
                .delete()
                .eq('id', int.parse(id));
          }
          return const Right(null);
        },
        errorResolver: const GenericErrorResolver(),
      );

  Future<bool> _isFirebaseLogin() async {
    final loginType = await _localStorageService.getLoginType();
    return loginType == LoginType.firebase.name;
  }
}
