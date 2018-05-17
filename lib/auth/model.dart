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

  @override
  toString() => 'AuthState{user: $user}';
}

@immutable
abstract class User {
  String get id;
  String get name;

  @override
  String toString() => 'User{id: $id, name: $name}';
}

@immutable
class FirebaseBackedUser implements User {
  final FirebaseUser firebaseUser;

  @override
  String get id => firebaseUser.uid;

  @override
  String get name => firebaseUser.displayName;

  FirebaseBackedUser({@required this.firebaseUser});

  @override
  String toString() => 'FirebaseBackedUser{id: $id, name: $name}';
}
