import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:sipudak/widget/my_header.dart';
import 'package:sipudak/theme.dart';
import 'package:sipudak/widget/my_headerPp.dart';

class Panduan extends StatelessWidget {
  const Panduan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          MyHeaderPp(
              image: "assets/guide.png",
              texttop: "Panduan Pelaporan",
              textbottom: ""),
          Card(
            margin: EdgeInsets.all(20),
            child: Container(
                child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Sebelum melakukan pelaporan sebaiknya pelajari terlebih dahulu cara-cara pelaporan",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(""),
                ),
                ListTile(
                  title: Text(
                    "1. Peraturan Presiden Nomor 65 Tahun 2020 Tentang Kementrian Pemberdayaan Perempuan dan Perlindungan Anak ",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(""),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
