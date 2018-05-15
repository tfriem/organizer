import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';

import '../app/model.dart';
import '../core/date.dart';
import 'actions.dart';
import 'model.dart';

WorkTimeTrackerState workTimeTrackerReducer(
    WorkTimeTrackerState state, dynamic action) {
  if (action is WorkTimeBookingsLoadingSucceeded) {
    return WorkTimeTrackerState(action.bookings, state.selectedDate);
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
  }

  next(action);
}

Map<Date, Booking> _convertDocumentsToBookings(List<DocumentSnapshot> docs) {
  return Map.fromEntries(docs.map((doc) {
    final start = doc.data['start'] as DateTime;
    final end = doc.data['end'] as DateTime;
    final breakTime = Duration(minutes: doc.data['break']);

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
