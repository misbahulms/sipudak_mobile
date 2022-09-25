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
import './detail_laporan_list.dart';
import 'package:intl/intl.dart';

import 'dart:io';
import 'package:dio/dio.dart';
import '../network/api/url_api.dart';

class LaporanListPage extends StatefulWidget {
  const LaporanListPage({Key? key}) : super(key: key);

  @override
  State<LaporanListPage> createState() => _LaporanListPageState();
}

class _LaporanListPageState extends State<LaporanListPage> {
  bool _isLoading = false;
  var _jumlahKasus = [];

  Future getHistoryLaporan() async {
    setState(() {
      _isLoading = true;
    });

    var dio = Dio();
    dio.options
      ..baseUrl = BASEURL.ipAddress
      ..connectTimeout = 100000
      ..receiveTimeout = 100000
      // ..queryParameters = {"jk": "laki-laki"}
      // ..validateStatus = (status) {
      //   return status! > 0;
      // }
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        'common-header': 'xx',
      };
    try {
      var response = await dio.get(
        "${BASEURL.pelaporan}",
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      final data = response.data;
      var status = data['status'];
      // String message = data['message'];
      print(data);

      if (status) {
        setState(() {
          _isLoading = false;
          _jumlahKasus = data['data'];
        });

        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("eror $e");

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHistoryLaporan();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: RefreshIndicator(
          onRefresh: () async => await getHistoryLaporan(),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 5),
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => Beranda(),
                        //     ));
                      },
                      icon: Icon(Icons.arrow_back_outlined),
                      color: Colors.black,
                      iconSize: 30),
                  SizedBox(width: 20),
                  Text("Notifikasi Laporan", style: kTitleTextstyle)
                ],
              ),
              // MyHeaderInfo(
              //     image: "assets/bro.png",
              //     texttop: "Tindak Tegas",
              //     textbottom: "Kekerasan"),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                      children: _jumlahKasus.map((e) {
                    // _jumlahKasus.sort(
                    //     (a, b) => b['id_pelapor'].compareTo(a['id_pelapor']));
                    return News(
                      image: "assets/law.png",
                      judul:
                          "${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.parse(e["tanggal_pelaporan"]))}",
                      title:
                          "Kronologis kejadian:\n${e['kronologis_kejadian']}",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailLaporanList(data: e)));
                      },
                    );
                  }).toList()))
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
        ),
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
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          // margin: EdgeInsets.symmetric(vertical: 10),
          height: 100,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Container(
                height: 100,
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
              Positioned(
                  left: 7,
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: AssetImage("assets/profil.png"),
                  )),
              Positioned(
                  left: 45,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    height: 136,
                    width: MediaQuery.of(context).size.width,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info,
                              size: 17,
                              color: Colors.lightBlue,
                            ),
                            SizedBox(width: 5),
                            Expanded(
                                child: Text(title,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 12))),
                            Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Icon(
                                      Icons.keyboard_arrow_right,
                                      size: 30,
                                      color: Colors.black45,
                                    ))),
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ));
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
