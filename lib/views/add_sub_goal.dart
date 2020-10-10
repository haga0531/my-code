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
  final subGoalInputController = TextEditingController();
  String _error;

  Future<void> _selectDatee(BuildContext context) async {
    final DateTime pickedDatee = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020, 1),
        lastDate: new DateTime.now().add(new Duration(days: 360)),
        locale: const Locale('ja'));
    if (pickedDatee != null) {
      setState(() {
        _pickedDate = pickedDatee.toString();
      });
    }
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
    return Column(
      children: [
        showAlert(),
        Container(
          child: TextFormField(
            controller: subGoalInputController,
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
                if (subGoalInputController.text == '' ||
                    _pickedDate == '締め切り') {
                  setState(() {
                    _error = 'ゴールと締め切りを決めてください';
                  });
                  return;
                }
                addGoal(subGoalInputController.text, _pickedDate);
                subGoalInputController.clear();
                _pickedDate = '締め切り';
              },
            ),
          ),
        )
      ],
    );
  }
}
