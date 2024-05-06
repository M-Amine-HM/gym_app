import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:table_calendar/table_calendar.dart';

class calendar extends StatefulWidget {
  const calendar({super.key});

  @override
  State<calendar> createState() => _calendarState();
}

class _calendarState extends State<calendar> {
  DateTime today = DateTime.now();
  void _ondayselected(DateTime day, DateTime day1) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendrier"),
      ),
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        Container(
            // child: TableCalendar(
            //     locale: "en_US",
            //     selectedDayPredicate: (day) => isSameDay(day, today),
            //     onDaySelected: _ondayselected,
            //     availableGestures: AvailableGestures.all,
            //     headerStyle:
            //         HeaderStyle(formatButtonVisible: false, titleCentered: true),
            //     focusedDay: today,
            //     firstDay: DateTime.utc(2010, 10, 16),
            //     lastDay: DateTime.utc(2030, 10, 16)),
            ),
      ],
    );
  }
}
