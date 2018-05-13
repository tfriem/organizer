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
  final bool loggedIn;
  final VoidCallback login;
  final VoidCallback logout;

  LoginViewModel(this.loggedIn, this.login, this.logout);
}

class LoginState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginViewModel>(
      converter: (Store<AppState> store) => new LoginViewModel(
          store.state.auth.loggedIn,
          () => store.dispatch(Actions.login),
          () => store.dispatch(Actions.logout)),
      builder: (BuildContext context, LoginViewModel vm) {
        return new Column(children: <Widget>[
          Text(vm.loggedIn.toString()),
          OutlineButton(
            onPressed: vm.login,
            child: Text("Login"),
          ),
          OutlineButton(
            onPressed: vm.logout,
            child: Text("Logout"),
          )
        ]);
      },
    );
  }
}
