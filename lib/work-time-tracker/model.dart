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
}

@immutable
class Booking {
  final DateTime start;
  final DateTime end;
  final Duration breakDuration;

  Booking(this.start, this.end, this.breakDuration);
}
