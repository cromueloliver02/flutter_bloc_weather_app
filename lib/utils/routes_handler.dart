import 'package:flutter/cupertino.dart';

import '../pages/pages.dart';

class RoutesHandler {
  final Map<String, WidgetBuilder> routes = {
    HomePage.id: (ctx) => const HomePage(),
    SearchPage.id: (ctx) => const SearchPage(),
    SettingsPage.id: (ctx) => const SettingsPage(),
  };
}
