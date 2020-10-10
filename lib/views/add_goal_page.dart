import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:mycode/model/goal.dart';
import 'package:mycode/views/add_main_goal.dart';
import 'package:mycode/views/add_sub_goal.dart';
import 'package:mycode/views/sub_goal_list.dart';

class AddGoalPage extends StatefulWidget {
  @override
  _AddGoalPageState createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  // Widget _buildAnotherGoal() {
  //   return ListView.builder(
  //     itemCount: 1,
  //     itemBuilder: (BuildContext context, int index) {
  //       return _listItem();
  //     },
  //   );
  // }
  List<Goal> _goalLists = [];

  void _addNewGoal(String title, String date) {
    final newGoal = Goal(title: title, date: date);
    setState(() {
      _goalLists.add(newGoal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              })),
      body: Container(
        margin: EdgeInsets.fromLTRB(25, 40, 25, 0),
        child: Column(
          children: [
            Container(
              child: AddMainGoal(),
            ),
            SizedBox(
              height: 30,
            ),
            SubGoalList(_goalLists),
            Container(
              child: AddSubGoal(_addNewGoal),
            ),
          ],
        ),
      ),
    );
  }
}
