import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:sipudak/theme.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'package:sipudak/home.dart';

// import '../../utils/pallete.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

//------------------ Default config ------------------
class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Peta Daerah Rawan Kekerasan",
        description: "Peta Sebaran Daerah Rawan Kekerasan Kabupaten Sambas",
        backgroundColor: Colors.white,
        pathImage: "assets/peta.jpg",
        // foregroundImageFit: BoxFit.fill,
        // backgroundImageFit: BoxFit.fill,
        heightImage: 270,
        widthImage: 270,
        styleDescription: TextStyle(
            color: blueColor, fontSize: 23, fontWeight: FontWeight.bold),
        styleTitle: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
    slides.add(
      new Slide(
        title: "Pelaporan Kasus Kekerasan",
        description:
            "Pelaporan kasus tidak perlu lagi datang ke kantor hanya dengan sentuhan",
        pathImage: "assets/brono.png",
        backgroundColor: Colors.white,
        heightImage: 270,
        widthImage: 270,
        styleDescription: TextStyle(
            color: blueColor, fontSize: 23, fontWeight: FontWeight.bold),
        styleTitle: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
    slides.add(
      new Slide(
        title: "Call Center",
        description: "Konsultasi layanan tindak kekerasan yang dialami",
        pathImage: "assets/amico.png",
        backgroundColor: Colors.white,
        heightImage: 270,
        widthImage: 270,
        styleDescription: TextStyle(
            color: blueColor, fontSize: 23, fontWeight: FontWeight.bold),
        styleTitle: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
    checkLogin();
  }

  void onDonePress() {
    // Do what you want

    if (userId.isEmpty || userId == "0") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Login()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomePage(idUser: int.parse(userId))));
    }
  }

  void onSkipPress() {
    // Do what you want

    if (userId.isEmpty || userId == "0") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Login()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomePage(idUser: int.parse(userId))));
    }
  }

  String userId = "";

  startTime() async {
    return Timer(
        Duration(seconds: 3),
        () => userId == "0" || userId.isEmpty
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
    // startTime();
    // if (nostartTime_Hp != null && password != null) {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => HomePage(idUser: int.parse(id_user))));
    // }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // checkLogin();
  // }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      colorSkipBtn: blueColor,
      colorDoneBtn: yellowColor,
      onSkipPress: this.onSkipPress,
    );
  }
}
