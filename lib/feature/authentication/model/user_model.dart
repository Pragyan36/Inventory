import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String companyName;
  final String fullName;
  final String email;
  final String password;
  final String? profilePic;

  const UserModel({
    this.id,
    required this.companyName,
    required this.fullName,
    required this.email,
    required this.password,
    this.profilePic,
  });

  toJson() {
    return {
      "CompanyName": companyName,
      "FullName": fullName,
      "Email": email,
      "Password": password,
      if (profilePic != null) "ProfilePic": profilePic,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      companyName: data["CompanyName"] ?? "",
      fullName: data["FullName"] ?? "",
      email: data["Email"] ?? "",
      password: data["Password"] ?? "",
      profilePic: data["ProfilePic"],
    );
  }
}
