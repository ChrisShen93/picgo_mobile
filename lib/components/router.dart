import 'package:flutter/material.dart';

import '../pages/settings.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/setting':
      return MaterialPageRoute(builder: (ctx) => SettingsPage());
    default:
      return MaterialPageRoute(builder: (ctx) => SettingsPage());
  }
}
