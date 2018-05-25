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

  static OrganizerLocalization of(BuildContext context) {
    return Localizations.of<OrganizerLocalization>(
        context, OrganizerLocalization);
  }

  String get loginMessage {
    return Intl.message(
      'Login with Google',
      name: 'loginMessage',
      desc: 'Login message',
    );
  }

  String get timesTitle {
    return Intl.message('Times',
        name: 'timesTitle', desc: 'Title for booking times screen');
  }

  String get overviewTitle {
    return Intl.message('Overview',
        name: 'overviewTitle', desc: 'Title for times overview screen');
  }

  String get graphsTitle {
    return Intl.message('Graphs',
        name: 'graphsTitle', desc: 'Title for graphs screen');
  }

  String get workDay {
    return Intl.message('Work day?',
        name: 'workDay', desc: 'Work day option while booking times');
  }
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
