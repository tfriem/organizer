import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';

import 'data.dart';
import 'work_time_tracker.dart';

void main() {
  final store =
      new Store<AppState>(appReducer, initialState: AppState.initialState());
  _auth().then((user) => print(user));
  runApp(new OrganizerApp(store: store));
}

Future<FirebaseUser> _auth() async {
  final _auth = FirebaseAuth.instance;

  GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  FirebaseUser user = await _auth.signInWithGoogle(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  print("signed in " + user.displayName);
  return user;
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
