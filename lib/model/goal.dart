import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Goal {
  final String title;
  final String date;

  Goal({@required this.title, this.date});

  Goal.fromMap(Map map)
      : title = map['title'],
        date = map['date'];

  Goal.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data);

  Map toJson() {
    return {
      'titile': title,
      'date': date,
    };
  }
}
