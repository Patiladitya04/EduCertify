import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String role;
  final String? phone;
  final String? department;
  final String? batch;
  final String? profilePhotoUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.phone,
    this.department,
    this.batch,
    this.profilePhotoUrl,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      id: snapshot.id,
      email: data?['email'] ?? '',
      name: data?['name'] ?? '',
      role: data?['role'] ?? '',
      phone: data?['phone'],
      department: data?['department'],
      batch: data?['batch'],
      profilePhotoUrl: data?['profilePhotoUrl'],
      createdAt: (data?['createdAt'] as Timestamp).toDate(),
      updatedAt: data?['updatedAt'] != null
          ? (data?['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id.isNotEmpty) 'id': id,
      'email': email,
      'name': name,
      'role': role,
      'phone': phone,
      'department': department,
      'batch': batch,
      'profilePhotoUrl': profilePhotoUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
