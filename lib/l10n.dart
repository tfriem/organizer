import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class OrganizerLocalization {
  static Future<OrganizerLocalization> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new OrganizerLocalization();
    });
  }

  static OrganizerLocalization of(BuildContext context) =>
      Localizations.of<OrganizerLocalization>(context, OrganizerLocalization);

  String get timesTitle => Intl.message('Times',
      name: 'timesTitle', desc: 'Title for booking times screen');

  String get overviewTitle => Intl.message('Overview',
      name: 'overviewTitle', desc: 'Title for times overview screen');

  String get chartsTitle => Intl.message('Charts',
      name: 'chartsTitle', desc: 'Title for graphs screen');

  String get workDay => Intl.message('Work day?',
      name: 'workDay', desc: 'Work day option while booking times');

  String overviewBookedDays(days) => Intl.message('Booked days: $days',
      name: 'overviewBookedDays',
      desc: 'Label for number of booked days',
      args: [days]);

  String overviewAverageStarting(time) =>
      Intl.message('Average starting time: $time',
          name: 'overviewAverageStarting',
          desc: 'Label for the average starting time',
          args: [time]);

  String overviewAverageEnd(time) => Intl.message('Average end time: $time',
      name: 'overviewAverageEnd',
      desc: 'Label for the average end time',
      args: [time]);

  String overviewAverageDuration(duration) =>
      Intl.message('Average work duration: $duration',
          name: 'overviewAverageDuration',
          desc: 'Label for the average work duration',
          args: [duration]);

  String overviewDurationSum(sum) => Intl.message('Sum: $sum',
      name: 'overviewDurationSum', desc: 'Sum of overtime', args: [sum]);

  String get detailWorkTime => Intl.message('Work time:',
      name: 'detailWorkTime', desc: 'Work time for a day');
}

class OrganizerLocalizationsDelegate
    extends LocalizationsDelegate<OrganizerLocalization> {
  const OrganizerLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'de'].contains(locale.languageCode);

  @override
  Future<OrganizerLocalization> load(Locale locale) =>
      OrganizerLocalization.load(locale);

  @override
  bool shouldReload(OrganizerLocalizationsDelegate old) => false;
}
