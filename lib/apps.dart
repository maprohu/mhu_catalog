import 'package:recase/recase.dart';

enum App {
  invoicesPortugal,
  pizzaFlutter,
  everythingSolver,
}

extension AppX on App {
  String get packageName => name.snakeCase;
  String get iconSvgFileName => "$packageName.svg";
}