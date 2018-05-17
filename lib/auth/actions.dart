import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
class UserAuthenticationSucceeded {
  final FirebaseUser firebaseUser;

  UserAuthenticationSucceeded(this.firebaseUser);

  @override
  toString() =>
      'UserAuthenticationSucceded{uid: ${firebaseUser.uid}, displayName: ${firebaseUser.displayName}}';
}
