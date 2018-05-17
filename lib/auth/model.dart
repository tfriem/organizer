import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
class AuthState {
  final User user;

  AuthState({this.user});
  AuthState.initialState() : user = null;

  AuthState copyWith({User user}) {
    return AuthState(user: user ?? this.user);
  }
}

@immutable
abstract class User {
  String get id;
  String get name;
}

@immutable
class FirebaseBackedUser implements User {
  final FirebaseUser firebaseUser;

  @override
  String get id => firebaseUser.uid;

  @override
  String get name => firebaseUser.displayName;

  FirebaseBackedUser({@required this.firebaseUser});
}
