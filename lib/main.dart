import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sipudak/home.dart';
import 'package:sipudak/pages/info_screen.dart';
import 'package:sipudak/pages/login.dart';
import 'package:sipudak/pages/register.dart';
import 'package:sipudak/pages/splash_screen.dart';
import 'package:sipudak/pages/tingkat_kekerasan.dart';
import 'package:sipudak/theme.dart';
// import "package:dcdg/dcdg.dart";
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('id')],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: yellowColor),
      home: SplashScreen(),
    );
  }
}

// I/flutter (12402): {nama: Muhammad Imanudin, email: mimdudin@gmail.com, no_hp: 123213131, alamat: sadsadadada, password: 123}
// 2
// I/flutter (12402): {status: true, message: data user berhasil ditambah}