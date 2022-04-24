import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:sipudak/pages/login.dart';
import 'package:sipudak/services/image_services.dart';
import 'package:sipudak/theme.dart';
import 'package:sipudak/widget/button_primary.dart';
import 'package:sipudak/widget/logo.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:sipudak/widget/my_headerAn.dart';
import 'package:sipudak/widget/my_headerPL.dart';
import 'package:sipudak/network/api/url_api.dart';

import '../theme.dart';
import 'info_screen.dart';

class Pelaporan extends StatefulWidget {
  const Pelaporan({Key? key}) : super(key: key);

  @override
  _PelaporanState createState() => _PelaporanState();
}

class _PelaporanState extends State<Pelaporan> {
  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  bool _isLoading = false;

  File? image;
  var _korbanKekerasan = TextEditingController();
  var _tempatKejadian = TextEditingController();
  var _alamatKejadian = TextEditingController();
  var _hubunganDgnKorban = TextEditingController();
  var _tanggalPelaporan = TextEditingController();
  var _alamatPelapor = TextEditingController();
  var _nomorHp = TextEditingController();
  var _desaKejadian = TextEditingController();
  var _kronologisKejadian = TextEditingController();

  Future _validateAndSubmit(BuildContext context) async {
    if (_korbanKekerasan.text.isEmpty &&
        _tempatKejadian.text.isEmpty &&
        _alamatKejadian.text.isEmpty &&
        _hubunganDgnKorban.text.isEmpty &&
        _tanggalPelaporan.text.isEmpty &&
        _alamatKejadian.text.isEmpty &&
        _nomorHp.text.isEmpty &&
        _desaKejadian.text.isEmpty &&
        _kronologisKejadian.text.isEmpty) {
    } else {
      await submitLaporan(context);
    }
  }

  Future submitLaporan(BuildContext context) async {
  setState(() {
    _isLoading = true;
  });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var dio = Dio();
    dio.options
      ..baseUrl = BASEURL.ipAddress
      ..connectTimeout = 10000 //5s
      ..receiveTimeout = 10000
      // ..validateStatus = (status) {
      //   return status >  0;
      // }
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
        'common-header': 'xx',
      };

    // _isLoadingUser = true;
    // notifyListeners();

    print(_nomorHp.text);
    print(_kronologisKejadian.text);

    try {
      var responseData = await dio.post(
        BASEURL.pelaporan,
        
        data: {
          'id_pelapor': "1",
          'id_user': "1",
          'alamat_pelapor': _alamatPelapor.text,
          'no_hp': _nomorHp.text,
          'korban_kekerasan': _korbanKekerasan.text,
          // 'tanggal_pelaporan': "2021-07-15 00:00:00",
          'tempat_kejadian': _tempatKejadian.text,
          'alamat_kejadian': _alamatKejadian.text,
          'kronologis_kejadian': _kronologisKejadian.text,
          // 'image': "graduate-icon-png-28-2.png",
          'id_status': "2",
          'hubungan_dengan_korban': _hubunganDgnKorban.text,
          'id_desa': "1",
          // 'date_created': "2022-07:15 00:00:00",
        },
        options: Options(
           responseType: ResponseType.plain,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      // print(Constant.login);

      print("RESPONSE: $responseData");

      if (responseData.data['status']) {
        // await Future.wait([
        //   prefs.setString('nomorHp', nomorHpController.text),
        //   prefs.setString('password', passwordController.text),
        // ]);

        setState(() {
          //if there is no error, get the user's accesstoken and pass it to HomeScreen
          String accessToken = responseData.data['data'];
          _isLoading = false;
        });

        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => HomePage()));
        // notifyListeners();

        print(responseData.data['message']);
      } else {
        print(responseData.data['message']);
        //if an error occurs, show snackbar with error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${responseData.data['Message']}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    } catch (e) {
      print("catch $e");
    }

    // _isLoadingUser = false;
    // notifyListeners();

    // return users;
  }

  @override
  Widget build(BuildContext context) {
    var whiteColor;
    return Scaffold(
      body: ListView(
        children: [
          MyHeaderPL(
              image: "assets/sad-little.png",
              texttop: "Laporkan Tindak Kekerasan",
              textbottom: "Lindungi Perempuan dan Anak"),
          // Container(
          //   child: LogoSpace(
          //     child: SizedBox(
          //       height: 2,
          //     ),
          //   ),
          // ),
          Container(
              color: Colors.white,
              padding: EdgeInsets.all(24),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Form Pelaporan",
                      style: regulerTextStyle.copyWith(fontSize: 20),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Silakan Isi Data Pelaporan Anda",
                      style: regulerTextStyle.copyWith(
                          fontSize: 15, color: greyBoldColor),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    // TextField
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: kShadowColor,
                                offset: Offset(0, 1),
                                blurRadius: 1,
                                spreadRadius: 0)
                          ],
                          color: whiteColor),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _korbanKekerasan,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Korban Kekerasan',
                            hintStyle: lightTextStyle.copyWith(
                                fontSize: 15, color: greyLightColor)),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: kShadowColor,
                                offset: Offset(0, 1),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                          color: whiteColor),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _tempatKejadian,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tempat Kejadian',
                            hintStyle: lightTextStyle.copyWith(
                                fontSize: 15, color: greyLightColor)),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: kShadowColor,
                                offset: Offset(0, 1),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                          color: whiteColor),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _alamatKejadian,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Alamat Kejadian',
                            hintStyle: lightTextStyle.copyWith(
                                fontSize: 15, color: greyLightColor)),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: kShadowColor,
                                offset: Offset(0, 1),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                          color: whiteColor),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _hubunganDgnKorban,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Hubungan Dengan Korban',
                            hintStyle: lightTextStyle.copyWith(
                                fontSize: 15, color: greyLightColor)),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: kShadowColor,
                                offset: Offset(0, 1),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                          color: whiteColor),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _tanggalPelaporan,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tanggal Pelaporan',
                            hintStyle: lightTextStyle.copyWith(
                                fontSize: 15, color: greyLightColor)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: kShadowColor,
                                offset: Offset(0, 1),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                          color: whiteColor),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _alamatPelapor,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Alamat Pelapor',
                            hintStyle: lightTextStyle.copyWith(
                                fontSize: 15, color: greyLightColor)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: kShadowColor,
                                offset: Offset(0, 1),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                          color: whiteColor),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _nomorHp,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nomor Hp',
                            hintStyle: lightTextStyle.copyWith(
                                fontSize: 15, color: greyLightColor)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: kShadowColor,
                                offset: Offset(0, 1),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                          color: whiteColor),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _desaKejadian,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Desa Kejadian',
                            hintStyle: lightTextStyle.copyWith(
                                fontSize: 15, color: greyLightColor)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 16),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: kShadowColor,
                                offset: Offset(0, 1),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                          color: whiteColor),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _kronologisKejadian,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Kronologis Kejadian',
                            hintStyle: lightTextStyle.copyWith(
                                fontSize: 15, color: greyLightColor)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    // imageKorban(),
                    Center(
                      child: Stack(
                        children: <Widget>[
                          image != null
                              ? (kIsWeb
                                  ? CircleAvatar(
                                      radius: 80.0,
                                      backgroundImage:
                                          NetworkImage(image!.path),
                                    )
                                  : CircleAvatar(
                                      radius: 80.0,
                                      backgroundImage:
                                          FileImage(File(image!.path)),
                                    ))
                              : CircleAvatar(
                                  radius: 80.0,
                                  backgroundImage:
                                      AssetImage("assets/profil.png"),
                                ),
                          Positioned(
                              bottom: 20,
                              right: 20,
                              child: InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) => Wrap(
                                            children: [
                                              ListTile(
                                                leading: Icon(Icons.camera_alt),
                                                title: Text("Kamera"),
                                                onTap: () async {
                                                  try {
                                                    var result =
                                                        await ImageServices
                                                            .selectImage(
                                                                isGallery:
                                                                    false);
                                                    if (result != null) {
                                                      setState(() {
                                                        image = result;
                                                      });
                                                    }
                                                  } catch (e) {
                                                    print(e);
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.perm_media),
                                                title: Text("Galeri"),
                                                onTap: () async {
                                                  try {
                                                    var result =
                                                        await ImageServices
                                                            .selectImage(
                                                                isGallery:
                                                                    true);
                                                    if (result != null) {
                                                      setState(() {
                                                        image = result;
                                                      });
                                                    }
                                                  } catch (e) {
                                                    print(e);
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              ),
                                            ],
                                          ));
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.teal,
                                      size: 28.0,
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ButtonPrimary(
                        text: "Laporkan !",
                        onTap: () async {
                          await _validateAndSubmit(context);
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) => Login()));
                        },
                      ), 
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

// Future<File> getImage() async {
//   return await ImagePicker.pickImage(source: ImageSource.gallery);
// }
  Widget imageKorban() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            backgroundImage: AssetImage("assets/profil.png"),
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: InkWell(
                onTap: () async {
                  var result = await ImageServices.selectImage(isGallery: true);
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Center(
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.teal,
                      size: 28.0,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
