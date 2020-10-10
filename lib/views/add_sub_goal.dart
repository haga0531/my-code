import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddSubGoal extends StatefulWidget {
  final Function addGoal;
  AddSubGoal(this.addGoal);
  @override
  _AddSubGoalState createState() => _AddSubGoalState(addGoal);
}

class _AddSubGoalState extends State<AddSubGoal> {
  Function addGoal;
  _AddSubGoalState(this.addGoal);
  var _pickedDate = '締め切り';
  final goalInputController = TextEditingController();

  Future<void> _selectDatee(BuildContext context) async {
    final DateTime pickedDatee = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020, 1),
        lastDate: new DateTime.now().add(new Duration(days: 360)),
        locale: const Locale('ja'));
    // final date = DateFormat('yyyy/HH/mm').format(pickedDate);
    if (pickedDatee != null) {
      setState(() {
        _pickedDate = pickedDatee.toString();
      });
    }
  }

  addGoadForm() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TextFormField(
            controller: goalInputController,
            decoration:
                InputDecoration(labelText: '中間ゴールを決めましょう', hintText: '教科書1週'),
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
                onPressed: () => _selectDatee(context),
              ),
            ],
          ),
        ),
        Center(
          child: Ink(
            decoration: const ShapeDecoration(
                shape: CircleBorder(), color: Colors.blueGrey),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                addGoal(goalInputController.text, _pickedDate);
                goalInputController.clear();
                _pickedDate = '締め切り';
              },
            ),
          ),
        )
      ],
    );
  }
}
