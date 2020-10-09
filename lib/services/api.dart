import 'package:firebase_auth/firebase_auth.dart';

class Api {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // signup
  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    return (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  // signin
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _auth.signInWithEmailAndPassword(email: null, password: null))
        .user
        .uid;
  }

  Stream<String> get onAuthStateChanged =>
      _auth.onAuthStateChanged.map((FirebaseUser user) => user?.uid);
}
