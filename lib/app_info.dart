import 'package:mhu_dart_commons/commons.dart';

import 'apps.dart';

part 'app_info.freezed.dart';

@freezed
class AppInfo with _$AppInfo {
  const factory AppInfo({
    required String title,
    String? googlePlay,
    String? appleStore,
    String? webLink,
    String? github,
    String? googleInternalTesting,
  }) = _AppInfo;
}

final appInfo = {
  App.invoicesPortugal: const AppInfo(
    title: "Appy Invoices Portugal",
    appleStore: null,
    googlePlay: null,
    webLink: null,
    googleInternalTesting: "https://play.google.com/apps/internaltest/4700434247829700466",
  ),
  App.everythingSolver: const AppInfo(
    title: "Everything Solver",
    appleStore: null,
    googlePlay: null,
    googleInternalTesting: null,
    webLink: "https://maprohu.github.io/everything_solver/",
    github: "https://github.com/maprohu/everything_solver",
  ),
  App.pizzaFlutter: const AppInfo(
    title: "Appy Pizza",
    googlePlay: "https://play.google.com/store/apps/details?id=hu.mapro.pizza_flutter",
    appleStore: "https://apps.apple.com/pt/app/appy-pizza/id6451199303",
    googleInternalTesting: "https://play.google.com/apps/internaltest/4701488945597886072",
    webLink: "https://maprohu.github.io/pizza_flutter/",
    github: "https://github.com/maprohu/pizza_flutter",
  ),
};
