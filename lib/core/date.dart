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

  DateTime toDateTime() => DateTime(year, month, day);

  @override
  String toString() =>
      '$year${month.toString().padLeft(2,'0')}${day.toString().padLeft(2, '0')}';

  bool operator ==(o) =>
      o is Date && o.year == year && o.month == month && o.day == day;

  int get hashCode => year * 10000 + month * 100 + day;
}
