import 'package:meta/meta.dart';

import '../auth/model.dart';
import '../work-time-tracker/model.dart';

@immutable
class AppState {
  final AuthState auth;
  final WorkTimeTrackerState workTimeTracker;

  AppState({this.auth, this.workTimeTracker});
  AppState.initialState()
      : auth = AuthState.initialState(),
        workTimeTracker = WorkTimeTrackerState.initialState();

  AppState copyWith({auth, workTimeTracker}) {
    return AppState(
        auth: auth ?? this.auth,
        workTimeTracker: workTimeTracker ?? this.workTimeTracker);
  }

  @override
  String toString() =>
      'AuthState{auth: $auth, workTimeTracker: $workTimeTracker}';
}
