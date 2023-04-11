// @dart = 2.9
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/customcolor.dart';
import 'views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
          primaryTextTheme:
              Theme.of(context).primaryTextTheme.apply(bodyColor: Colors.black),
          appBarTheme: (AppBarTheme(
            color: Colors.white,
            shadowColor: Colors.transparent,
            elevation: 0,
            //   iconTheme: IconThemeData(color: Colors.white),
            //   actionsIconTheme: IconThemeData(color: Colors.white),
            //   toolbarTextStyle: TextStyle(color: Colors.white),
          ))),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
