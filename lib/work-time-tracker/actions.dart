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
