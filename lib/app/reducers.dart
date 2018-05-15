import '../auth/reducers.dart';
import '../work-time-tracker/reducers.dart';
import 'model.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(authReducer(state.auth, action),
      workTimeTrackerReducer(state.workTimeTracker, action));
}
