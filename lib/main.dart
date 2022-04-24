import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sipudak/home.dart';
import 'package:sipudak/pages/info_screen.dart';
import 'package:sipudak/pages/login.dart';
import 'package:sipudak/pages/register.dart';
import 'package:sipudak/pages/splash_screen.dart';
import 'package:sipudak/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: yellowColor),
      home: HomePage(),
    );
  }
}
