import 'package:firebase_test/features/auth/domain/entities/user.dart';
import 'package:firebase_test/features/users/data/repositories/users_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/base_state_notifier.dart';

final usersNotifierProvider =
    StateNotifierProvider<UsersNotifier, BaseState<List<User>>>(
  (ref) => UsersNotifier(ref.watch(usersRepositoryProvider), ref)..getUsers(),
);

class UsersNotifier extends BaseStateNotifier<List<User>> {
  final UsersRepository _usersRepository;

  UsersNotifier(this._usersRepository, ref) : super(ref);

  Future<void> getUsers() async {
    state = const BaseState.loading();
    final result = await _usersRepository.getUsers();
    result.fold(
      (failure) {
        setGlobalFailure(failure);
        state = BaseState.error(failure);
      },
      (users) {
        state = BaseState.data(users);
      },
    );
  }
}
