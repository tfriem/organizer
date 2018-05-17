import '../auth/reducers.dart';
import '../work-time-tracker/reducers.dart';
import 'model.dart';

AppState appReducer(AppState state, dynamic action) {
  return state.copyWith(
      auth: authReducer(state.auth, action),
      workTimeTracker: workTimeTrackerReducer(state.workTimeTracker, action));
}
