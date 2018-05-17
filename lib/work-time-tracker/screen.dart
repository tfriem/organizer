import 'package:flutter/material.dart';

import 'booking_detail.dart';
import 'horizontal_calendar.dart';
import 'graph.dart';

class WorkTimeTrackerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Work Time Tracker'),
            bottom: TabBar(
              tabs: <Widget>[Tab(text: 'Buchen'), Tab(text: 'Auswertung')],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Expanded(child: BookingDetail()),
                  Container(height: 100.0, child: HorizontalCalendar())
                ],
              ),
              Column(
                children: <Widget>[Expanded(child: Graph())],
              )
            ],
          )),
    );
  }
}
