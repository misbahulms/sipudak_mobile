import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sipudak/pages/register.dart';
import 'package:sipudak/widget/button_primary.dart';
import 'package:sipudak/widget/logo.dart';
import 'package:sipudak/widget/widget_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LogoSpace(
          child: Column(
        children: [
          SizedBox(
            height: 45,
          ),
          WidgetLogo(
            image: "assets/Si Pudak.png",
            title: "Sistem Informasi Geografis",
            subtitle1: "Pemetaan Tingkat Kekerasan",
            subtitle2: "Terhadap Perempuan dan Anak",
            child: ButtonPrimary(
              text: "Mulai",
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Register()));
              },
            ),
          )
        ],
      )),
    );
  }
}
