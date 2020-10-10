import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddMainGoal extends StatefulWidget {
  @override
  _AddMainGoalState createState() => _AddMainGoalState();
}

class _AddMainGoalState extends State<AddMainGoal> {
  var _pickedDate = '締め切り';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020, 1),
        lastDate: new DateTime.now().add(new Duration(days: 360)),
        locale: const Locale('ja'));
    // final date = DateFormat('yyyy/HH/mm').format(pickedDate);
    if (pickedDate != null) {
      setState(() {
        _pickedDate = pickedDate.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TextFormField(
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
}
