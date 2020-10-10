import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycode/model/goal.dart';

class SubGoalList extends StatelessWidget {
  final List<Goal> subGoalList;
  SubGoalList(this.subGoalList);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: subGoalList != null
            ? subGoalList.map((e) {
                return Card(
                  margin: const EdgeInsets.all(5),
                  child: Container(
                    width: 400,
                    height: 100,
                    child: Row(
                      children: [
                        Text(e.title),
                        Text(DateFormat('yyyy-MM-dd')
                            .format(DateTime.parse(e.date))),
                      ],
                    ),
                  ),
                );
              }).toList()
            : [],
      ),
    );
  }
}
