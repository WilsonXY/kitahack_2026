import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FoodServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Future<DocumentSnapshot> getFoodData(String uid) async {
  //   return await _db.collection('food').doc(uid).get();
  // }

  Future<void> saveFood(String uid,Map<String,dynamic> rawData) async {
    await _db.collection('user').doc(uid).collection('foods').add(rawData);
  }

  // TODO : Wait for Nicholas since Firebase Storage need Blaze Plan
  // Future<String> saveFoodImages(String uid,Uint8List imageBytes) async {
  //   await _storage.bucket();
  //   return ;
  // }
}
