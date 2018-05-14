import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class User {
  String get id;
  String get name;
}

class FirebaseBackedUser implements User {
  final FirebaseUser firebaseUser;

  @override
  String get id => firebaseUser.uid;

  @override
  String get name => firebaseUser.displayName;

  FirebaseBackedUser({@required this.firebaseUser});
}
