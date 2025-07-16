import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventorymanagement/feature/authentication/model/user_model.dart';

class Poststate extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  Future<String?> createUser(UserModel user) async {
    try {
      await _db
          .collection("user")
          .doc(auth.currentUser!.uid)
          .set(user.toJson());
      print("✅ Firestore user data written successfully!");
      return null;
    } catch (error) {
      print("❌ Firestore error: $error");
      return "Error: ${error.toString()}";
    }
  }
}
