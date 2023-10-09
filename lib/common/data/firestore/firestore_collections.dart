import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/common/constants/firebase_constants.dart';

class FirestoreCollections {
  static final usersCollection = FirebaseFirestore.instance
      .collection(FirebaseConstants.usersCollection)
      .get();
}
