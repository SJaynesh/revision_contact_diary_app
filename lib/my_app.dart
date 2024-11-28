import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revision_contact_diary_app/controllers/contact_controlller.dart';
import 'package:revision_contact_diary_app/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactController(),
        ),
      ],
      builder: (context, child) => child!,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: Routes.myRoutes,
      ),
    );
  }
}
