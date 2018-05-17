import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../core/date.dart';
import 'model.dart';

@immutable
class WorkTimeBookingsLoadingRequestet {}

@immutable
class WorkTimeBookingsLoadingSucceeded {
  final Map<Date, Booking> bookings;

  WorkTimeBookingsLoadingSucceeded(this.bookings);

  @override
  String toString() => 'WorkTimeBookingsLoadingSucceded{bookings: $bookings}';
}

@immutable
class WorkTimeSelectDay {
  final Date selectedDay;

  WorkTimeSelectDay(this.selectedDay);

  @override
  String toString() => 'WorkTimeSelectDay{selectedDay: $selectedDay}';
}

@immutable
class WorkTimeChangeStartTime {
  final Date day;
  final TimeOfDay newTime;

  WorkTimeChangeStartTime(this.day, this.newTime);

  @override
  String toString() => 'WorkTimeChangeStartTime{day: $day, newTime: $newTime}';
}

@immutable
class WorkTimeChangeEndTime {
  final Date day;
  final TimeOfDay newTime;

  WorkTimeChangeEndTime(this.day, this.newTime);

  @override
  String toString() => 'WorkTimeChangeEndTime{day: $day, newTime: $newTime}';
}
