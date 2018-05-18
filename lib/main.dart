import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'app/actions.dart';
import 'app/model.dart';
import 'app/reducers.dart';
import 'auth/reducers.dart';
import 'work-time-tracker/reducers.dart';
import 'work-time-tracker/screen.dart';

void main() {
  initializeDateFormatting("de_DE");
  Intl.defaultLocale = "de_DE";

  final store = Store<AppState>(appReducer,
      initialState: AppState.initialState(),
      middleware: [
        LoggingMiddleware.printer(
            formatter: LoggingMiddleware.multiLineFormatter),
        authMiddleware,
        workTimeTrackerMiddleware
      ]);
  store.dispatch(AppInitialized());
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
        home: WorkTimeTrackerScreen(),
      ),
    );
  }
}
