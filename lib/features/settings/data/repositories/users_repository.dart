import 'package:either_dart/either.dart';
import 'package:firebase_test/common/data/firestore/firestore_collections.dart';
import 'package:firebase_test/common/data/generic_error_resolver.dart';
import 'package:firebase_test/features/auth/domain/entities/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

final usersRepositoryProvider =
    Provider<UsersRepository>((ref) => UsersRepositoryImpl());

abstract class UsersRepository {
  EitherFailureOr<List<User>> getUsers();
}

class UsersRepositoryImpl with ErrorToFailureMixin implements UsersRepository {
  @override
  EitherFailureOr<List<User>> getUsers() => execute(
        () async {
          final result = await FirestoreCollections.usersCollection.then(
            (value) => value.docs.map((e) => User.fromJson(e.data())).toList(),
          );
          return Right(result);
        },
        errorResolver: const GenericErrorResolver(),
      );
}
