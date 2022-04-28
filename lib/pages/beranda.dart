import 'package:flutter/material.dart';
import 'package:sipudak/pages/info_screen.dart';
import 'package:sipudak/theme.dart';
import 'package:sipudak/widget/kasus.dart';
import 'package:sipudak/widget/my_header.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
  var _jumlahKasus = 0;

  Future getLaporanKasus() async {
    setState(() {
      _isLoading = true;
    });

    var dio = Dio();
    dio.options
      ..baseUrl = BASEURL.ipAddress
      ..connectTimeout = 10000
      ..receiveTimeout = 10000
      // ..validateStatus = (status) {
      //   return status! > 0;
      // }
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        'common-header': 'xx',
      };
    try {
      var response = await dio.get(
        BASEURL.korban,
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
                                    jumlah: _jumlahKasus,
                                    title: "Jumlah Kasus",
                                  ),
                                  Kasus(
                                    color: kRecovercolor,
                                    jumlah: 100,
                                    title: "Perempuan",
                                  ),
                                  Kasus(
                                    color: kDeathColor,
                                    jumlah: 100,
                                    title: "Anak",
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
                            center: LatLng(1.3523149, 109.2868825),
                            zoom: 18.0,
                          ),
                          layers: [
                            TileLayerOptions(
                                urlTemplate:
                                    'http://{s}.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}',
                                subdomains: ['mt0', 'mt1', 'mt2', 'mt3'])
                          ],
                        ),
                      ),
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
