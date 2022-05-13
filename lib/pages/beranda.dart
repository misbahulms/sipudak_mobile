import 'package:flutter/material.dart';
import 'package:sipudak/pages/info_screen.dart';
import 'package:sipudak/theme.dart';
import 'package:sipudak/widget/kasus.dart';
import 'package:sipudak/widget/my_header.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import './laporan_list_page.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import '../network/api/url_api.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  bool _isLoading = false;
  var _jumlahKasus = [];

  Future getLaporanKasus() async {
    setState(() {
      _isLoading = true;
    });

    var dio = Dio();
    dio.options
      ..baseUrl = BASEURL.ipAddress
      ..connectTimeout = 10000
      ..receiveTimeout = 10000
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
        "${BASEURL.korban}",
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
    getLaporanKasus();
  }

  @override
  Widget build(BuildContext context) {
    var sejangkung = <LatLng>[];
    var selakau_timur = <LatLng>[];
    var selakau = <LatLng>[];
    var semparuk = <LatLng>[];
    var subah = <LatLng>[];
    var tangaran = <LatLng>[];
    var tebas = <LatLng>[];
    var tekarang = <LatLng>[];
    var teluk_keramat = <LatLng>[];
    var galing = <LatLng>[
      LatLng(1.741976158000087, 109.40636167700002),
      LatLng(1.741186173000093, 109.40793512800009),
      LatLng(1.741007741000073, 109.408290519),
      LatLng(1.738392181000021, 109.41253437300006),
      LatLng(1.737908537000061, 109.41417360300005),
    ];

    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
            onRefresh: () async => await getLaporanKasus(),
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                MyHeader(
                  image: "assets/violen.png",
                  texttop: "Stop Kekerasan",
                  textbottom: "Perempuan dan \nAnak",
                ),
                //
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Kasus Terbaru\n",
                                style: kTitleTextstyle),
                            TextSpan(
                                text: "update terbaru desember 2021",
                                style: lightTextStyle.copyWith(
                                    color: greyLightColor)),
                          ])),
                          Spacer(),
                          Text(
                            "Selengkapnya",
                            style: boldTextStyle.copyWith(
                                color: blueColor, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 135,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 30,
                                color: kShadowColor,
                              )
                            ]),
                        child: _isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Kasus(
                                    color: kInfectedColor,
                                    jumlah: _jumlahKasus.toList().length,
                                    title: "Jumlah Kasus",
                                  ),
                                  Kasus(
                                    color: kRecovercolor,
                                    jumlah: _jumlahKasus
                                        .where((element) =>
                                            element['jenis_kelamin'] ==
                                            "Perempuan")
                                        .toList()
                                        .length,
                                    title: "Perempuan",
                                  ),
                                  Kasus(
                                    color: kDeathColor,
                                    jumlah: _jumlahKasus
                                        .where((element) =>
                                            element['jenis_kelamin'] ==
                                            "Laki-Laki")
                                        .toList()
                                        .length,
                                    title: "Laki-laki",
                                  ),
                                ],
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Sebaran kasus",
                            style: kTitleTextstyle1,
                          ),
                          Text(
                            "Selengkapnya",
                            style: TextStyle(
                                color: blueColor, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Container(
                          height: 400,
                          child: FlutterMap(
                              options: MapOptions(
                                // center: LatLng(51.5, -0.09),
                                center: LatLng(1.3523149, 109.2868825),
                                zoom: 9.0,
                                // zoom: 18.0,
                              ),
                              layers: [
                                TileLayerOptions(
                                    urlTemplate:
                                        // 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    // subdomains: ['a', 'b', 'c']),
                                'http://{s}.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}',
                                subdomains: ['mt0', 'mt1', 'mt2', 'mt3']),
                                PolygonLayerOptions(
                                  polygons: [
                                    Polygon(
                                      points: galing,
                                      // isFilled: false, // By default it's false
                                      color: Colors.purple,
                                      borderColor: Colors.red,
                                      borderStrokeWidth: 4.0,
                                    ),
                                    // Polygon(
                                    //   points: sejangkung,
                                    //   // isFilled: true,
                                    //   color: Colors.purple,
                                    //   borderColor: Colors.purple,
                                    //   borderStrokeWidth: 4.0,
                                    // ),
                                    // Polygon(
                                    //   points: selakau_timur,
                                    //   // isFilled: false,
                                    //   isDotted: true,
                                    //   borderColor: Colors.green,
                                    //   borderStrokeWidth: 4.0,
                                    // ),
                                    // Polygon(
                                    //   points: semparuk,
                                    //   // isFilled: true,
                                    //   isDotted: true,
                                    //   borderStrokeWidth: 4.0,
                                    //   borderColor: Colors.lightBlue,
                                    //   color: Colors.lightBlue,
                                    // ),
                                  ],
                                ),
                              ]))

                      // Container(
                      //   margin: EdgeInsets.only(top: 20),
                      //   padding: EdgeInsets.all(20),
                      //   height: 165,
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(20),
                      //     color: Colors.white,
                      //     boxShadow: [
                      //       BoxShadow(
                      //         offset: Offset(0, 10),
                      //         blurRadius: 30,
                      //         color: kShadowColor,
                      //       )
                      //     ],
                      //   ),
                      //   child: Image.asset("assets/map.png", fit: BoxFit.contain),
                      // ),
                    ],
                  ),
                ),
              ],
            ))),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InfoScreen(),
                    ));
              },
              label: const Text('Lapor'),
              icon: const Icon(Icons.report),
              backgroundColor: blueColor),
        ),
      ),
    );
  }
}
