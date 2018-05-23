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
  final bool isWorkDay;

  Booking(this.start, this.end, this.breakDuration, this.isWorkDay);

  bool isFullyBooked() => start != null && end != null;

  @override
  String toString() =>
      'Booking{start: $start, end: $end, breakDuration: $breakDuration}';
}
