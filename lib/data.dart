import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(authReducer(state.auth, action),
      workTimeTrackerReducer(state.workTimeTracker, action));
}

AuthState authReducer(AuthState state, dynamic action) {
  if (action is UserLoadedAction) {
    return new AuthState(FirebaseBackedUser(firebaseUser: action.firebaseUser));
  }
  return state;
}

WorkTimeTrackerState workTimeTrackerReducer(
    WorkTimeTrackerState state, dynamic action) {
  if (action is WorkTimeDataLoaded) {
    return new WorkTimeTrackerState(action.bookings);
  }
  return state;
}

class AppState {
  final AuthState auth;
  final WorkTimeTrackerState workTimeTracker;

  AppState(this.auth, this.workTimeTracker);
  AppState.initialState()
      : auth = AuthState.initialState(),
        workTimeTracker = WorkTimeTrackerState.initialState();
}

class AuthState {
  final User user;

  AuthState(this.user);
  AuthState.initialState() : user = null;
}

class Date {
  final int year;
  final int month;
  final int day;

  Date(this.year, this.month, this.day);

  Date.fromDocumentId(String documentId)
      : year = int.parse(documentId.substring(0, 4)),
        month = int.parse(documentId.substring(4, 6)),
        day = int.parse(documentId.substring(6, 8));

  DateTime asDateTime() => DateTime(year, month, day);
}

class WorkTimeData {
  final DateTime start;
  final DateTime end;
  final Duration breakDuration;

  WorkTimeData(this.start, this.end, this.breakDuration);
}

class WorkTimeTrackerState {
  final Map<Date, WorkTimeData> bookings;

  WorkTimeTrackerState(this.bookings);
  WorkTimeTrackerState.initialState() : bookings = {};
}

class InitAppAction {}

class UserLoadedAction {
  final FirebaseUser firebaseUser;

  UserLoadedAction(this.firebaseUser);
}

class LoadWorkTimeData {}

class WorkTimeDataLoaded {
  final Map<Date, WorkTimeData> bookings;

  WorkTimeDataLoaded(this.bookings);
}

firebaseMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is InitAppAction) {
    FirebaseAuth.instance.currentUser().then((user) {
      if (user != null) {
        store.dispatch(UserLoadedAction(user));
        store.dispatch(LoadWorkTimeData());
      } else {
        _handleLogin().then((user) => store.dispatch(UserLoadedAction(user)));
      }
    });
  } else if (action is LoadWorkTimeData) {
    Firestore.instance
        .collection('WorkTimeTracker')
        .where('owner', isEqualTo: store.state.auth.user.id)
        .snapshots()
        .listen((data) {
      print(data);

      store.dispatch(WorkTimeDataLoaded(
          Map.fromEntries(data.documents.map((DocumentSnapshot doc) {
        final start = doc.data['start'] as DateTime;
        final end = doc.data['end'] as DateTime;
        final breakTime = Duration(minutes: doc.data['break']);

        return MapEntry<Date, WorkTimeData>(Date.fromDocumentId(doc.documentID),
            WorkTimeData(start, end, breakTime));
      }))));
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
