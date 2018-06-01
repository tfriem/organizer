import 'package:redux/redux.dart';

import '../auth/reducers.dart';
import '../main.dart';
import '../work-time-tracker/reducers.dart';
import 'actions.dart';
import 'model.dart';

AppState appReducer(AppState state, dynamic action) {
  return state.copyWith(
      auth: authReducer(state.auth, action),
      workTimeTracker: workTimeTrackerReducer(state.workTimeTracker, action));
}

navigationMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is RoutePush) {
    navigatorKey.currentState.pushNamed(action.target);
  } else if (action is RouteReplace) {
    navigatorKey.currentState.pushReplacementNamed(action.target);
  }
  next(action);
}
