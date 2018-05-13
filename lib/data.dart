import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(authReducer(state.auth, action));
}

AuthState authReducer(AuthState state, dynamic action) {
  if (action is UserLoadedAction) {
    return new AuthState(action.firebaseUser);
  }
  return state;
}

class AppState {
  final AuthState auth;

  AppState(this.auth);
  AppState.initialState() : auth = AuthState.initialState();
}

class AuthState {
  final FirebaseUser firebaseUser;

  AuthState(this.firebaseUser);
  AuthState.initialState() : firebaseUser = null;
}

class InitAppAction {}

class UserLoadedAction {
  final FirebaseUser firebaseUser;

  UserLoadedAction(this.firebaseUser);
}

firebaseMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is InitAppAction) {
    FirebaseAuth.instance.currentUser().then((user) {
      if (user != null) {
        store.dispatch(UserLoadedAction(user));
      } else {
        _handleLogin().then((user) => store.dispatch(UserLoadedAction(user)));
      }
    });
  }
  next(action);
}

Future<FirebaseUser> _handleLogin() async {
  GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  FirebaseUser user = await FirebaseAuth.instance.signInWithGoogle(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  return user;
}
