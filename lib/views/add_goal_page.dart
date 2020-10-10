import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:mycode/model/goal.dart';
import 'package:mycode/views/add_sub_goal.dart';
import 'package:mycode/views/home_page.dart';
import 'package:mycode/views/sub_goal_list.dart';

class AddGoalPage extends StatefulWidget {
  @override
  _AddGoalPageState createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  List<Goal> _goalLists = [];
  var _pickedDate = '締め切り';
  final mainGoalInputController = TextEditingController();
  String _error;

  void _addNewGoal(String title, String date) {
    final newGoal = Goal(title: title, date: date);
    setState(() {
      _goalLists.add(newGoal);
    });
  }

  submit() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    DocumentReference goals = Firestore.instance.collection('goals').document();

    final subGoalLists = [];
    for (var i = 0; i < _goalLists.length; i++) {
      subGoalLists.add({
        'subGoalTitle': _goalLists[i].title,
        'subGoalDeadline': _goalLists[i].date,
      });
    }
    // todo mainDeadlineよりsubDeadlineの方が遅かったらアラートかける
    goals.setData({
      'userId': currentUser.uid,
      'mainGoalTitle': mainGoalInputController.text,
      'mainGoalDeadline':
          DateFormat('yyyy-MM-dd').format(DateTime.parse(_pickedDate)),
      'subGoalLists': subGoalLists,
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020, 1),
        lastDate: new DateTime.now().add(new Duration(days: 360)),
        locale: const Locale('ja'));
    if (pickedDate != null) {
      setState(() {
        _pickedDate = pickedDate.toString();
      });
    }
  }

  Widget _buildMainGoal() {
    return Column(
      children: [
        Container(
          child: TextFormField(
            controller: mainGoalInputController,
            decoration:
                InputDecoration(labelText: 'ゴールを決めましょう', hintText: '司法試験合格'),
          ),
        ),
        Container(
          child: Row(
            children: [
              Text(
                _pickedDate == '締め切り'
                    ? '締め切り'
                    : DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(_pickedDate)),
                style: TextStyle(fontSize: 18),
              ),
              IconButton(
                icon: Icon(Icons.date_range),
                onPressed: () => _selectDate(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
                child: Text(
              _error,
              maxLines: 3,
            )),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _error = null;
                    });
                  }),
            )
          ],
        ),
      );
    }
    return SizedBox();
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              showAlert(),
              Container(
                child: _buildMainGoal(),
              ),
              SizedBox(
                height: 30,
              ),
              SubGoalList(_goalLists),
              Container(
                child: AddSubGoal(_addNewGoal),
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                onPressed: () async {
                  if (mainGoalInputController.text == '' ||
                      _pickedDate == '締め切り') {
                    setState(() {
                      _error = 'ゴールと締め切りを決めてください';
                    });
                    return;
                  }
                  submit().then((success) {
                    mainGoalInputController.clear();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  });
                },
                child: Text(
                  '保存する',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blueGrey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
