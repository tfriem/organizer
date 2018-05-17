import 'package:meta/meta.dart';

import '../core/date.dart';

@immutable
class WorkTimeTrackerState {
  final Map<Date, Booking> bookings;
  final Date selectedDate;

  WorkTimeTrackerState(this.bookings, this.selectedDate);
  WorkTimeTrackerState.initialState()
      : bookings = {},
        selectedDate = Date.fromDateTime(DateTime.now());

  @override
  String toString() =>
      'WorkTimeTrackerState{bookings: $bookings, selectedDate: $selectedDate}';
}

@immutable
class Booking {
  final DateTime start;
  final DateTime end;
  final Duration breakDuration;

  Booking(this.start, this.end, this.breakDuration);

  @override
  String toString() =>
      'Booking{start: $start, end: $end, breakDuration: $breakDuration}';
}
