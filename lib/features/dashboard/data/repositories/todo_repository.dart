import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/common/constants/firebase_constants.dart';
import 'package:firebase_test/common/data/firestore/firestore_collections.dart';
import 'package:firebase_test/common/data/generic_error_resolver.dart';
import 'package:firebase_test/common/data/services/local_storage_service.dart';
import 'package:firebase_test/features/auth/domain/entities/login_type.dart';
import 'package:firebase_test/features/dashboard/domain/entities/todo.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

final todoRepositoryProvider = Provider<TodoRepository>(
  (ref) => TodoRepositoryImpl(
    ref.watch(localStorageServiceProvider),
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

  final _todoRef = FirestoreCollections.todosCollection;

  TodoRepositoryImpl(this._localStorageService);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  StreamFailureOr<List<Todo>> getTodos() async* {
    if (await _isFirebaseLogin()) {
      final userReference = FirebaseAuth.instance.currentUser?.uid;
      try {
        yield* FirestoreCollections.todosCollection
            .where(FirebaseConstants.userField, isEqualTo: userReference)
            .orderBy(FirebaseConstants.createdAtField, descending: true)
            .snapshots()
            .map(
              (snapshot) => Right(snapshot.docs.map((e) => e.data()).toList()),
            );
      } catch (e) {
        yield Left(Failure.generic());
      }
    }
  }

  @override
  EitherFailureOr<void> addTodo({
    required Todo todo,
  }) async {
    try {
      final todoRef = _todoRef.doc(todo.id);
      final newTodo = todo.copyWith(id: todoRef.id);
      await todoRef.set(newTodo, SetOptions(merge: true));

      return const Right(null);
    } catch (e) {
      debugPrint(e.toString());
      return Left(Failure.generic());
    }
  }

  @override
  EitherFailureOr<void> toggleComplete(
          {required String id, required bool isCompleted}) =>
      execute(
        () async {
          await _todoRef.doc(id).update({
            FirebaseConstants.isCompletedField: isCompleted,
          });

          return const Right(null);
        },
        errorResolver: const GenericErrorResolver(),
      );

  @override
  EitherFailureOr<void> deleteTodo({required String id}) => execute(
        () async {
          await _todoRef.doc(id).delete();
          return const Right(null);
        },
        errorResolver: const GenericErrorResolver(),
      );

  // @override
  // EitherFailureOr<void> deleteTodo({
  //   required String id,
  // }) {
  //   try {
  //     await _firestore.collection('todos').doc(id).delete();
  //     return const Right(null);
  //   } catch (e) {
  //     return Left(Failure.generic());
  //   }
  // }

  Future<bool> _isFirebaseLogin() async {
    final loginType = await _localStorageService.getLoginType();
    return loginType == LoginType.firebase.name;
  }
}
