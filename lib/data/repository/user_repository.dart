import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_space_deer/data/models/user_model.dart';

class UserRepository {
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('users');
  Future<List<UserModel>> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    return querySnapshot.docs.map((dynamic doc) {
      return UserModel.fromJson(doc.data());
    }).toList();
  }
}
