import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'data.dart';
import 'work_time_tracker.dart';

void main() {
  final store = new Store<AppState>(appReducer,
      initialState: AppState.initialState(),
      middleware: [firebaseMiddleware].toList());
  store.dispatch(InitAppAction());
  runApp(new OrganizerApp(store: store));
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
