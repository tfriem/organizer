import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'data.dart';

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
  final FirebaseUser firebaseUser;

  LoginViewModel(this.firebaseUser);
}

class LoginState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginViewModel>(
      converter: (Store<AppState> store) =>
          new LoginViewModel(store.state.auth.firebaseUser),
      builder: (BuildContext context, LoginViewModel vm) {
        return new Column(children: <Widget>[
          Text(vm.firebaseUser?.displayName ?? 'Not logged in.'),
        ]);
      },
    );
  }
}
