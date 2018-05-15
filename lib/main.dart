import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'app/actions.dart';
import 'app/model.dart';
import 'app/reducers.dart';
import 'auth/reducers.dart';
import 'work-time-tracker/reducers.dart';
import 'work-time-tracker/screen.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initialState(),
      middleware: [authMiddleware, workTimeTrackerMiddleware]);
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
          brightness: Brightness.dark,
          primarySwatch: Colors.grey,
        ),
        home: WorkTimeTrackerScreen(),
      ),
    );
  }
}
