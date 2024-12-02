import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_app.dart';

late SharedPreferences preferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  runApp(
    const MyApp(),
  );
}
