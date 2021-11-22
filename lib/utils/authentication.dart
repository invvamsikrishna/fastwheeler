import 'package:firebase_auth/firebase_auth.dart';
class Authentication {
  Future<String> signin(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "SignedIn";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<String> signup(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return "SignedUp";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}
