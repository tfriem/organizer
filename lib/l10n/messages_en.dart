// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'en';

  static m0(duration) => "Average work duration: ${duration}";

  static m1(time) => "Average end time: ${time}";

  static m2(time) => "Average starting time: ${time}";

  static m3(days) => "Booked days: ${days}";

  static m4(sum) => "Sum: ${sum}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "chartsTitle" : MessageLookupByLibrary.simpleMessage("Charts"),
    "detailWorkTime" : MessageLookupByLibrary.simpleMessage("Work time:"),
    "overviewAverageDuration" : m0,
    "overviewAverageEnd" : m1,
    "overviewAverageStarting" : m2,
    "overviewBookedDays" : m3,
    "overviewDurationSum" : m4,
    "overviewTitle" : MessageLookupByLibrary.simpleMessage("Overview"),
    "timesTitle" : MessageLookupByLibrary.simpleMessage("Times"),
    "workDay" : MessageLookupByLibrary.simpleMessage("Work day?")
  };
}
