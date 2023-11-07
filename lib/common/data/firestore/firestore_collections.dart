import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/common/constants/firebase_constants.dart';
import 'package:firebase_test/features/dashboard/domain/entities/todo.dart';

class FirestoreCollections {
  static final usersCollection = FirebaseFirestore.instance
      .collection(FirebaseConstants.usersCollection)
      .get();

  static final todosCollection = FirebaseFirestore.instance
      .collection(FirebaseConstants.todosCollection)
      .withConverter<Todo>(
        fromFirestore: (data, _) {
          final dataWithId = data.data()?..addAll({'id': data.id});
          return Todo.fromJson(dataWithId ?? {});
        },
        toFirestore: (data, _) => data.toJson(),
      );
}
