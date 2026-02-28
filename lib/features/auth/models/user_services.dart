import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUserData(String uid) async {
    return await _db.collection('user').doc(uid).get();
  }

  Future<void> saveUserData(String uid, Map<String,dynamic> rawData) async {
    await _db.collection('user').doc(uid).set(rawData, SetOptions(merge: true));
  }

  Future<bool> checkUserExist(String uid) async {
    DocumentSnapshot doc = await _db.collection('user').doc(uid).get();
    return doc.exists;
  }

  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    await _db.collection('user').doc(uid).update(data);
  }
}
