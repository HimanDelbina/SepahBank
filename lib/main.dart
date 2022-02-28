import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sepah/Page/home.dart';
import 'package:sepah/Page/login.dart';
import 'package:sepah/test_sohaib.dart';

import 'Page/logo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fa', 'IR')],
      theme: ThemeData(fontFamily: "Vazir"),
      // home: const Home(),
      home: const Login(),
    );
  }
}
