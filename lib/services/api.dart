import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Api {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

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

  // listen auth state
  Stream<String> get onAuthStateChanged =>
      _auth.onAuthStateChanged.map((FirebaseUser user) => user?.uid);

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser = await _auth.currentUser();
    return currentUser;
  }

  Future getCurrentUserData() async {
    final user = await _auth.currentUser();
    DocumentSnapshot docSnapshot =
        await _firestore.collection('users').document('${user.uid}').get();
    return docSnapshot;
  }

  // fetch all goals
  Future<List> fetchAllGoals(FirebaseUser currentUser) async {
    FirebaseUser currentUser = await _auth.currentUser();
    QuerySnapshot goalDocs = await _firestore
        .collection('goals')
        .where('userId', isEqualTo: currentUser.uid)
        .getDocuments();

    List<DocumentSnapshot> goalList = goalDocs.documents;
    return goalList;
  }
}
