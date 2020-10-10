import 'package:flutter/material.dart';
import 'package:intl/locale.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;

  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 3.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TableCalendar(
                initialCalendarFormat: CalendarFormat.month,
                calendarController: _calendarController,
                locale: 'ja_JP',
                availableCalendarFormats: const {
                  CalendarFormat.month: '月',
                  CalendarFormat.twoWeeks: '2週間',
                  CalendarFormat.week: '週'
                },
                calendarStyle: CalendarStyle(
                    todayColor: Colors.white,
                    todayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.white),
                    selectedColor: Colors.blueGrey),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  centerHeaderTitle: true,
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (date, events) {
                  print(date.toIso8601String());
                },
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, events) => Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                  todayDayBuilder: (context, date, events) => Container(
                      alignment: Alignment.center,
                      child: Text(
                        'いま',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
