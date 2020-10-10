import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycode/model/goal.dart';

class SubGoalList extends StatelessWidget {
  final List<Goal> subGoalList;
  SubGoalList(this.subGoalList);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: subGoalList != null
            ? subGoalList.map((e) {
                return Card(
                  child: Row(
                    children: [
                      Text(e.title),
                      Text(DateFormat('yyyy-MM-dd')
                          .format(DateTime.parse(e.date))),
                    ],
                  ),
                );
              }).toList()
            : [],
      ),
    );
  }
}
