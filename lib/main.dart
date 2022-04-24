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
      home: Login(),
    );
  }
}

// I/flutter (12402): {nama: Muhammad Imanudin, email: mimdudin@gmail.com, no_hp: 123213131, alamat: sadsadadada, password: 123}
// 2
// I/flutter (12402): {status: true, message: data user berhasil ditambah}