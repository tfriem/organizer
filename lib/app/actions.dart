import 'package:meta/meta.dart';

@immutable
class NavigateAction {
  final String target;

  NavigateAction(this.target);
}
