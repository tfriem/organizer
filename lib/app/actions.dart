import 'package:meta/meta.dart';

@immutable
class RoutePush {
  final String target;

  RoutePush(this.target);
}

@immutable
class RouteReplace {
  final String target;

  RouteReplace(this.target);
}
