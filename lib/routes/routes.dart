import 'package:flutter/material.dart';

import '../view/screen/home_page.dart';

class Routes {
  static String homePage = '/';

  static Map<String, WidgetBuilder> myRoutes = {
    homePage: (ctx) => const HomePage(),
  };
}
