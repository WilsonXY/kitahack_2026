import 'package:cloud_firestore/cloud_firestore.dart';

class FoodServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Future<DocumentSnapshot> getFoodData(String uid) async {
  //   return await _db.collection('food').doc(uid).get();
  // }

  Future<void> saveFood(String uid,Map<String,dynamic> rawData) async {
    await _db.collection('user').doc(uid).collection('foods').add(rawData);
  }
}
