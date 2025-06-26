import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (!doc.exists) return null;

    return UserModel.fromFirestore(doc, null);
  }

  Future<UserModel?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final doc = await _firestore
          .collection('users')
          .doc(result.user!.uid)
          .get();

      return UserModel.fromFirestore(doc, null);
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  Future<UserModel?> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String role,
    String? phone,
    String? department,
    String? batch,
  ) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        id: result.user!.uid,
        email: email,
        name: name,
        role: role,
        phone: phone,
        department: department,
        batch: batch,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(user.id)
          .set(user.toFirestore());

      return user;
    } catch (e) {
      print('Error signing up: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  Future<void> updateProfile(
    String userId,
    String? name,
    String? phone,
    String? department,
    String? batch,
  ) async {
    try {
      final userRef = _firestore.collection('users').doc(userId);
      final userDoc = await userRef.get();

      if (userDoc.exists) {
        final userData = UserModel.fromFirestore(userDoc, null);
        final updatedUser = UserModel(
          id: userId,
          email: userData.email,
          name: name ?? userData.name,
          role: userData.role,
          phone: phone ?? userData.phone,
          department: department ?? userData.department,
          batch: batch ?? userData.batch,
          profilePhotoUrl: userData.profilePhotoUrl,
          createdAt: userData.createdAt,
          updatedAt: DateTime.now(),
        );

        await userRef.set(updatedUser.toFirestore());
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }
}
