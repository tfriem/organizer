import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../auth/actions.dart';
import 'model.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, WelcomeScreenViewModel>(
      converter: (Store<AppState> store) => WelcomeScreenViewModel(
          () => store.dispatch(UserAuthenticationRequested())),
      builder: (BuildContext context, WelcomeScreenViewModel vm) {
        // vm.login();
        return Scaffold(
            appBar: AppBar(
              title: Text('Organizer'),
            ),
            body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

@immutable
class WelcomeScreenViewModel {
  final VoidCallback login;

  WelcomeScreenViewModel(this.login);
}
