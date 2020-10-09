import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String email;
  String image;

  User({this.uid, this.name, this.email, this.image});

  User.fromMap(Map<String, dynamic> map) {
    this.uid = map['uid'];
    this.name = map['name'];
    this.email = map['email'];
    this.image = map['image'];
  }

  User.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);
}
