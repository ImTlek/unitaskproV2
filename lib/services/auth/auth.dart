import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

final AuthService authService = AuthService();

class AuthService {
  late final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> registration({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      } else {
        throw e.message.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user.';
      } else {
        throw e.message.toString();
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
