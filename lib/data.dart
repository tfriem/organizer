enum Actions { login, logout }

AppState appReducer(AppState state, dynamic action) {
  return AppState(authReducer(state.auth, action));
}

AuthState authReducer(AuthState state, dynamic action) {
  if (action == Actions.login) {
    return AuthState(loggedIn: true);
  }
  if (action == Actions.logout) {
    return AuthState(loggedIn: false);
  }
  return state;
}

class AppState {
  final AuthState auth;

  AppState(this.auth);
  AppState.initialState() : auth = AuthState.initialState();
}

class AuthState {
  final bool loggedIn;

  AuthState({this.loggedIn});
  AuthState.initialState() : loggedIn = false;
}
