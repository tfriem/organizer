import 'package:meta/meta.dart';

import '../core/date.dart';
import 'model.dart';

@immutable
class WorkTimeBookingsLoadingRequestet {}

@immutable
class WorkTimeBookingsLoadingSucceeded {
  final Map<Date, Booking> bookings;

  WorkTimeBookingsLoadingSucceeded(this.bookings);
}

@immutable
class WorkTimeSelectDay {
  final Date selectedDay;

  WorkTimeSelectDay(this.selectedDay);
}
