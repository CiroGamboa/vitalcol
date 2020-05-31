import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF319966),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Calendario",
          style: TextStyle(
            color: Color(0xFF319966),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: TableCalendar(
        calendarController: _calendarController,
      ),
    );
  }
}
