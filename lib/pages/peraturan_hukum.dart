import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:sipudak/widget/my_header.dart';
import 'package:sipudak/theme.dart';
import 'package:sipudak/widget/my_headerHk.dart';

class Peraturan extends StatelessWidget {
  const Peraturan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          MyHeaderHk(
              image: "assets/law.png",
              texttop: "Peraturan Hukum",
              textbottom: ""),
          Card(
            margin: EdgeInsets.all(20),
            child: Container(
                child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Berdasarkan Peraturan Pemerintah tentang Perlindungan Perempuan dan Anak",
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
                ListTile(
                  title: Text(
                    "2. Peraturan Menteri Pemberdayaan Perempuan dan Perlindungan Anak Nomor 4 Tahun 2018 tentang Pedoman Pembentukan Unit Pelaksana Teknis Daerah Perlindungan Perempuan dan Anak",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(""),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    "3. Peraturan Menteri Pemberdayaan Perempuan dan Perlindungan Anak Nomor 4 Tahun 2020 tentang Organisasi dan Tata Kerja Kementrian Pemberdayaan Perempuan dan Perlindungan Anak",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(""),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
