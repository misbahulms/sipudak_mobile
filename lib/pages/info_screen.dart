import 'package:flutter/material.dart';
import 'package:sipudak/home.dart';
import 'package:sipudak/pages/kekerasan_anak.dart';
import 'package:sipudak/pages/kekerasan_perempuan.dart';
import 'package:sipudak/pages/panduan_pelaporan.dart';
import 'package:sipudak/pages/pelaporan.dart';
import 'package:sipudak/theme.dart';
import 'package:sipudak/widget/my_header.dart';
import 'package:sipudak/pages/peraturan_hukum.dart';
import 'package:sipudak/widget/my_headerInfo.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeaderInfo(
                image: "assets/bro.png",
                texttop: "Tindak Tegas",
                textbottom: "Kekerasan"),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Bentuk Kekerasan",
                      style: kTitleTextstyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InfoCard(
                          image: "assets/Perempuan.png",
                          title: "Perempuan",
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Perempuan()));
                          },
                          isActive: true,

                          // link ke halaman bentuk kekeresan perempuan dan penjelasan jenis jenis kekerasan
                        ),
                        InfoCard(
                          image: "assets/Anak.png",
                          title: "Anak-Anak",
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Anak()));
                          },
                          // link ke halaman bentuk kekeresan perempuan dan penjelasan jenis jenis kekerasan
                        ),
                        InfoCard(
                          image: "assets/Laporkan 2.png",
                          title: "Laporkan !",
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Pelaporan()));
                          },
                          // link ke halaman form pelaporan
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Informasi",
                      style: kTitleTextstyle,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    News(
                      image: "assets/guide.png",
                      judul: "Panduan Pelaporan",
                      title: "Laporkan tindak kekerasan yang sedang anda alami",
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Panduan()));
                      },
                    ),
                    News(
                      image: "assets/law.png",
                      judul: "Peraturan Hukum",
                      title:
                          "Peraturan Hukum disini menjelaskan hal-hal yang menjadi dasar pelaporan kasus",
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Peraturan()));
                      },
                    ),
                    News(
                      image: "assets/rafiki.png",
                      judul: "Jangan Takut Lapor",
                      title: "Laporkan tindak kekerasan yang sedang anda alami",
                    ),
                  ],
                ))
          ],
        ),
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: FloatingActionButton.extended(
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => HomePage(),
        //             ));
        //       },
        //       label: const Text('Lapor'),
        //       icon: const Icon(Icons.report),
        //       backgroundColor: blueColor),
        // ),
      ),
    );
  }
}

class News extends StatelessWidget {
  final String image;
  final String judul;
  final String title;
  final onTap;
  const News({
    Key? key,
    required this.image,
    required this.judul,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 156,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Container(
            height: 136,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: kShadowColor,
                  )
                ]),
          ),
          Image.asset(
            image,
            width: 140,
          ),
          Positioned(
              left: 130,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 136,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextButton(
                      onPressed: onTap,
                      child: Text(
                        judul,
                        style: kTitleTextstyle.copyWith(fontSize: 16),
                      ),
                    ),
                    Text(title,
                        style: TextStyle(
                          fontSize: 12,
                        )),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final image;
  final title;
  final onTap;
  final bool isActive;
  const InfoCard({
    Key? key,
    this.image,
    this.title,
    this.onTap,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: kActiveShadowColor,
                )
              : BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  color: kShadowColor,
                ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(
            image,
            height: 60,
          ),
          TextButton(
              onPressed: onTap,
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
          // Text(
          //   title,
          //   style: TextStyle(fontWeight: FontWeight.bold),
          // ),
        ],
      ),
    );
  }
}
