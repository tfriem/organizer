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
      body: LoginState(),
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
          new LoginViewModel(store.state.auth.user),
      builder: (BuildContext context, LoginViewModel vm) {
        return new Column(children: <Widget>[
          Text(vm.user?.name ?? 'Not logged in.'),
        ]);
      },
    );
  }
}
