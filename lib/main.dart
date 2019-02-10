import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:organizer/auth/actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'app/model.dart';
import 'app/reducers.dart';
import 'app/welcome_screen.dart';
import 'auth/reducers.dart';
import 'l10n.dart';
import 'work-time-tracker/reducers.dart';
import 'work-time-tracker/screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  final middleware = [
    navigationMiddleware,
    authMiddleware,
    workTimeTrackerMiddleware
  ];

// Only enable logging in debug mode
  assert(() {
    middleware.add(
      LoggingMiddleware.printer(
          formatter: LoggingMiddleware.multiLineFormatter),
    );
    return true;
  }());

  final store = Store<AppState>(appReducer,
      initialState: AppState.initialState(), middleware: middleware);
  store.dispatch(UserAuthenticationRequested());
  runApp(OrganizerApp(store: store));
}

class OrganizerApp extends StatelessWidget {
  final Store<AppState> store;

  OrganizerApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Organizer',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.amberAccent,
        ),
        home: WelcomeScreen(),
        routes: <String, WidgetBuilder>{
          '/login': (context) => WelcomeScreen(),
          '/worktimetracker': (context) => WorkTimeTrackerScreen()
        },
        navigatorKey: navigatorKey,
        localizationsDelegates: [
          const OrganizerLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('de', 'DE'),
        ],
      ),
    );
  }
}
