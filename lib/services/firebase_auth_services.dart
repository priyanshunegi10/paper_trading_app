import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthSevices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> signupWithEmail(
    String email,
    String password,
    String name,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        await _db.collection("users").doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'name': name,
          'balance': 100000.0,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception("Login Error: $e");
    } catch (e) {
      throw Exception("Login Error: $e");
    }
  }

  Future<User?> loginWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception("Login Error: $e");
    } catch (e) {
      throw Exception("Login Error: $e");
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
