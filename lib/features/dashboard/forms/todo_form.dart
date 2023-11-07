import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/features/dashboard/domain/entities/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

final todoFormMapperProvider = Provider<FormMapper<Todo>>(
  (_) => TodoForm.authFromJson,
);

abstract class TodoForm {
  static const titleKey = 'title';
  static const descriptionKey = 'description';

  static Todo authFromJson(Map<String, dynamic> formMap) => Todo(
        title: formMap[titleKey],
        description: formMap[descriptionKey],
        userId: FirebaseAuth.instance.currentUser!.uid,
        isCompleted: false,
        createdAt: DateTime.now(),
      );
}
