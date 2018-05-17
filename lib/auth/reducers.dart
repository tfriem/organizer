import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';

import '../app/actions.dart';
import '../app/model.dart';
import '../work-time-tracker/actions.dart';
import 'actions.dart';
import 'model.dart';

AuthState authReducer(AuthState state, dynamic action) {
  if (action is UserAuthenticationSucceeded) {
    return state.copyWith(
        user: FirebaseBackedUser(firebaseUser: action.firebaseUser));
  }
  return state;
}

authMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is AppInitialized) {
    FirebaseAuth.instance.currentUser().then((user) {
      if (user != null) {
        store.dispatch(UserAuthenticationSucceeded(user));
        store.dispatch(WorkTimeBookingsLoadingRequestet());
      } else {
        _handleLogin()
            .then((user) => store.dispatch(UserAuthenticationSucceeded(user)));
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
