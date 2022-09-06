import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sipudak/home.dart';
import 'package:sipudak/pages/register.dart';
import 'login.dart';
import 'package:sipudak/widget/button_primary.dart';
import 'package:sipudak/widget/logo.dart';
import 'package:sipudak/widget/widget_logo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  final idUser;
  SplashScreen({Key? key, this.idUser}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userId = "";

  startTime() async {
    return Timer(
        Duration(seconds: 3),
        () => userId.isEmpty
            ? Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) => Login()))
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        HomePage(idUser: int.parse(userId)))));
  }

  Future checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? id_user = prefs.getString('id_user') ?? "0";
    String? no_Hp = prefs.getString('no_Hp');
    String? password = prefs.getString('password');

    print("check id_user: $id_user");
    print("check no_Hp: $no_Hp");
    print("check password: $password");
    setState(() {
      userId = id_user;
    });
    startTime();
    // if (nostartTime_Hp != null && password != null) {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => HomePage(idUser: int.parse(id_user))));
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkLogin();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WidgetLogo(
      image: "assets/Si Pudak.png",
      title: "Sistem Informasi Geografis",
      subtitle1: "Pemetaan Tingkat Kekerasan",
      subtitle2: "Terhadap Perempuan dan Anak",
      child: ButtonPrimary(
        text: "Mulai",
        onTap: () {
          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => Login()));
        },
      ),
    ));
  }
}



// class SplashScreen extends StatelessWidget {
//   final idUser;
//   SplashScreen({Key? key, this.idUser}) : super(key: key);


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LogoSpace(
//           child: Column(
//         children: [
//           SizedBox(
//             height: 45,
//           ),
//           WidgetLogo(
//             image: "assets/Si Pudak.png",
//             title: "Sistem Informasi Geografis",
//             subtitle1: "Pemetaan Tingkat Kekerasan",
//             subtitle2: "Terhadap Perempuan dan Anak",
//             // child: ButtonPrimary(
//             //   text: "Mulai",
//             //   onTap: () {
//             //     // Navigator.pushReplacement(
//             //     //     context,
//             //     //     MaterialPageRoute(
//             //     //         builder: (context) => Login()));
//             //   },
//             ),
//           )
//         ],
//       )),
//     );
//   }
// }
