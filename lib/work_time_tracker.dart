import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'data.dart';
import 'user.dart';

class WorkTimeTrackerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work Time Tracker'),
      ),
      body: new Column(
        children: <Widget>[LoginState(), DataDisplay()],
      ),
    );
  }
}

class LoginViewModel {
  final User user;

  LoginViewModel(this.user);
}

class LoginState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginViewModel>(
      converter: (Store<AppState> store) =>
          LoginViewModel(store.state.auth.user),
      builder: (BuildContext context, LoginViewModel vm) {
        return Column(children: <Widget>[
          Text(vm.user?.name ?? 'Not logged in.'),
        ]);
      },
    );
  }
}

class DataDisplayViewModel {
  final Map<Date, WorkTimeData> bookings;

  DataDisplayViewModel(this.bookings);
}

class DataDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DataDisplayViewModel>(
      converter: (Store<AppState> store) =>
          DataDisplayViewModel(store.state.workTimeTracker.bookings),
      builder: (BuildContext context, DataDisplayViewModel vm) {
        return Column(
            children: vm.bookings.entries.map((booking) {
          return Text(booking.key.asDateTime().toString());
        }).toList());
      },
    );
  }
}
