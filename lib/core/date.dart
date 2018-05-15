import 'package:meta/meta.dart';

@immutable
class Date {
  final int year;
  final int month;
  final int day;

  Date(this.year, this.month, this.day);

  Date.fromDateTime(DateTime dateTime)
      : year = dateTime.year,
        month = dateTime.month,
        day = dateTime.day;

  DateTime asDateTime() => DateTime(year, month, day);
}
