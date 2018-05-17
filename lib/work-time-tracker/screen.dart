import 'package:flutter/material.dart';

import 'booking_detail.dart';
import 'horizontal_calendar.dart';

class WorkTimeTrackerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work Time Tracker'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: BookingDetail()),
          Container(height: 100.0, child: HorizontalCalendar())
        ],
      ),
    );
  }
}
