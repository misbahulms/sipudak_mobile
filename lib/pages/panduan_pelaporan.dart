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
                    "1. Pahami dulu bentuk kekerasan perempuan atau anak",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(""),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    "2. Silahkan buka halaman Perempuan untuk melihat bentuk kekerasan terhadap perempuan",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(""),
                ),
                SizedBox(
                  height: 5,
                ),
                ListTile(
                  title: Text(
                    "3. Silahkan buka halaman Anak untuk melihat bentuk kekerasan terhadap anak",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(""),
                ),
                SizedBox(
                  height: 5,
                ),
                ListTile(
                  title: Text(
                    "4. Kemudian buka halaman peraturan untuk mengetahui hukum apa saja yang terkait kekerasan terhadap perempuan dan anak",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(""),
                ),
                SizedBox(
                  height: 5,
                ),
                ListTile(
                  title: Text(
                    "5. Silahkan lakukan pelaporan pada halaman Laporkan untuk melakukan pelaporan tindak kekerasan yang di alami atau yang terlihat",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(""),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
