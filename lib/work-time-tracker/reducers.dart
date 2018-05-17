import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../app/model.dart';
import '../core/date.dart';
import 'actions.dart';
import 'model.dart';

WorkTimeTrackerState workTimeTrackerReducer(
    WorkTimeTrackerState state, dynamic action) {
  if (action is WorkTimeBookingsLoadingSucceeded) {
    return WorkTimeTrackerState(action.bookings, state.selectedDate);
  } else if (action is WorkTimeSelectDay) {
    return WorkTimeTrackerState(state.bookings, action.selectedDay);
  }

  return state;
}

workTimeTrackerMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is WorkTimeBookingsLoadingRequestet) {
    Firestore.instance
        .collection('WorkTimeTracker')
        .where('owner', isEqualTo: store.state.auth.user.id)
        .snapshots()
        .listen((data) => store.dispatch(WorkTimeBookingsLoadingSucceeded(
            _convertDocumentsToBookings(data.documents))));
  } else if (action is WorkTimeChangeStartTime) {
    final data = {
      'start': _dateTimeFromDateAndDayOfTime(action.day, action.newTime),
      'owner': store.state.auth.user.id
    };
    Firestore.instance
        .collection('WorkTimeTracker')
        .document(_convertDateToDocumentId(action.day))
        .setData(data, merge: true);
  } else if (action is WorkTimeChangeEndTime) {
    final data = {
      'end': _dateTimeFromDateAndDayOfTime(action.day, action.newTime),
      'owner': store.state.auth.user.id
    };
    Firestore.instance
        .collection('WorkTimeTracker')
        .document(_convertDateToDocumentId(action.day))
        .setData(data, merge: true);
  }

  next(action);
}

Map<Date, Booking> _convertDocumentsToBookings(List<DocumentSnapshot> docs) {
  return Map.fromEntries(docs.map((doc) {
    final start = doc.data['start'] as DateTime;
    final end = doc.data['end'] as DateTime;
    final breakTime = Duration(minutes: doc.data['break'] ?? 30);

    return MapEntry<Date, Booking>(_convertDocumentIdToDate(doc.documentID),
        Booking(start, end, breakTime));
  }));
}

Date _convertDocumentIdToDate(String documentId) {
  final year = int.parse(documentId.substring(0, 4));
  final month = int.parse(documentId.substring(4, 6));
  final day = int.parse(documentId.substring(6, 8));

  return Date(year, month, day);
}

String _convertDateToDocumentId(Date date) {
  return '${date.year}${date.month.toString().padLeft(2,'0')}${date.day.toString().padLeft(2, '0')}';
}

DateTime _dateTimeFromDateAndDayOfTime(Date date, TimeOfDay time) {
  if (date == null || time == null) {
    return null;
  }
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}
