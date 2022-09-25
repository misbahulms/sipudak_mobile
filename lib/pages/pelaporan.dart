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
import 'package:intl/intl.dart';
// import 'package:sipudak/widget/my_headerAn.dart';
import 'package:sipudak/widget/my_headerPL.dart';
import 'package:sipudak/network/api/url_api.dart';

import '../theme.dart';
import 'info_screen.dart';

class Pelaporan extends StatefulWidget {
  final idUser;

  Pelaporan({Key? key, this.idUser}) : super(key: key);

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

  DateTime pickedDate = DateTime.now();
  var _desaList = [];

  List korban = [
    {'no': 1, 'value': 'Perempuan'},
    {'no': 2, 'value': 'Anak'},
  ];

  List<DropdownMenuItem<Object?>> _dropdownTestItems = [];
  var selectedkorban, selectedDesa;

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

    var dio = Dio();
    dio.options
      ..baseUrl = BASEURL.ipAddress
      ..connectTimeout = 1000000 //5s
      ..receiveTimeout = 1000000
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
    print({
      // 'id_pelapor': "1",
      'id_user': widget.idUser,
      'alamat_pelapor': _alamatPelapor.text,
      'no_hp': int.parse(_nomorHp.text),
      'korban_kekerasan': selectedkorban,
      'tanggal_pelaporan': pickedDate.toString(),
      'tempat_kejadian': _tempatKejadian.text,
      'alamat_kejadian': _alamatKejadian.text,
      'kronologis_kejadian': _kronologisKejadian.text,
      'image': await MultipartFile.fromFile(image!.path,
          filename: image!.path.split('/').last),
      'id_status': 1,
      'hubungan_dengan_korban': _hubunganDgnKorban.text,
      'id_desa': int.parse(selectedDesa['id_desa']),
      // 'date_created': "2022-07:15 00:00:00",
    });
    try {
      var responseData = await dio.post(
        BASEURL.pelaporan,
        data: FormData.fromMap({
          'id_user': widget.idUser,
          'alamat_pelapor': _alamatPelapor.text,
          'no_hp': int.parse(_nomorHp.text),
          'korban_kekerasan': selectedkorban,
          'tanggal_pelaporan': pickedDate.toString(),
          'tempat_kejadian': _tempatKejadian.text,
          'alamat_kejadian': _alamatKejadian.text,
          'kronologis_kejadian': _kronologisKejadian.text,
          'image': await MultipartFile.fromFile(image!.path,
              filename: image!.path.split('/').last),
          'id_status': 1,
          'hubungan_dengan_korban': _hubunganDgnKorban.text,
          'id_desa': int.parse(selectedDesa['id_desa']),
          // 'date_created': "2022-07:15 00:00:00",
        }),
        options: Options(
          //  responseType: ResponseType.plain,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("RESPONSE: $responseData");

      if (responseData.data['status']) {
        // await Future.wait([
        //   prefs.setString('nomorHp', nomorHpController.text),
        //   prefs.setString('password', passwordController.text),
        // ]);

        setState(() {
          // _desaList = responseData.data['data'];
          // var accessToken = responseData.data['data'][0];
          _isLoading = false;
        });
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Sukses Tambah Laporan"),
                  content: Text(
                      "Laporan anda sedang diproses, mohon menunggu info tindaklanjut"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("OKE"))
                  ],
                ));
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => HomePage()));
        // notifyListeners();

        print(responseData.data['message']);
      } else {
        setState(() {
          // var accessToken = responseData.data['data'][0];
          _isLoading = false;
        });
        print(responseData.data['message']);
        //if an error occurs, show snackbar with error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${responseData.data['Message']}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    } catch (e) {
      setState(() {
        // var accessToken = responseData.data['data'][0];
        _isLoading = false;
      });
      print("catch $e");
    }

    // _isLoadingUser = false;
    // notifyListeners();

    // return users;
  }

  Future fetchDesa() async {
    setState(() {
      _isLoading = true;
    });

    var dio = Dio();
    dio.options
      ..baseUrl = BASEURL.ipAddress
      ..connectTimeout = 100000 //5s
      ..receiveTimeout = 100000
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
      var responseData = await dio.get(
        BASEURL.desa,
        options: Options(
          //  responseType: ResponseType.plain,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      print("RESPONSE: $responseData");

      if (responseData.data['status']) {
        // await Future.wait([
        //   prefs.setString('nomorHp', nomorHpController.text),
        //   prefs.setString('password', passwordController.text),
        // ]);

        setState(() {
          _isLoading = false;

          _desaList = responseData.data['data'];
          // var accessToken = responseData.data['data'][0];
        });

        print("desa length: ${_desaList.length}");
        // Navigator.of(context).pop();
        // showDialog(
        //     context: context,
        //     builder: (context) => AlertDialog(
        //           title: Text("Sukses Tambah Laporan"),
        //           content: Text(
        //               "Laporan anda sedang diproses, mohon menunggu info tindaklanjut"),
        //           actions: [
        //             TextButton(
        //                 onPressed: () {
        //                   Navigator.pop(context);
        //                 },
        //                 child: Text("OKE"))
        //           ],
        //         ));
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => HomePage()));
        // notifyListeners();

        print(responseData.data['message']);
      } else {
        setState(() {
          // var accessToken = responseData.data['data'][0];
          _isLoading = false;
        });
        print(responseData.data['message']);
        //if an error occurs, show snackbar with error message
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text('Error: ${responseData.data['Message']}'),
        //   backgroundColor: Colors.red.shade300,
        // ));
      }
    } catch (e) {
      setState(() {
        // var accessToken = responseData.data['data'][0];
        _isLoading = false;
      });
      print("catch $e");
    }

    // _isLoadingUser = false;
    // notifyListeners();

    // return users;
  }

  @override
  void initState() {
    _dropdownTestItems = buildDropdownTestItems(korban);
    super.initState();

    fetchDesa();
  }

  @override
  Widget build(BuildContext context) {
    var whiteColor;
    return Scaffold(
      body: _isLoading
          ? Container(
              margin: EdgeInsets.only(top: 23.3),
              child: Column(
                children: [
                  MyHeaderPL(
                      image: "assets/sad-little.png",
                      texttop: "Laporkan Tindak Kekerasan",
                      textbottom: "Lindungi Perempuan dan Anak"),
                  Expanded(child: Center(child: CircularProgressIndicator()))
                ],
              ))
          : ListView(
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
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(
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
                              // Container(
                              //   padding: EdgeInsets.only(left: 16),
                              //   height: 50,
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(20),
                              //       boxShadow: [
                              //         BoxShadow(
                              //             color: kShadowColor,
                              //             offset: Offset(0, 1),
                              //             blurRadius: 1,
                              //             spreadRadius: 0)
                              //       ],
                              //       color: whiteColor),
                              //   width: MediaQuery.of(context).size.width,
                              //   child: TextField(
                              //     controller: _korbanKekerasan,
                              //     decoration: InputDecoration(
                              //         border: InputBorder.none,
                              //         hintText: 'Korban Kekerasan',
                              //         hintStyle: lightTextStyle.copyWith(
                              //             fontSize: 15, color: greyLightColor)),
                              //   ),
                              // ),
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(30)),
                                child: DropdownButton<String>(
                                  items: <String>['Perempuan', 'Anak']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  value: selectedkorban,
                                  isExpanded: true,
                                  underline: Container(),
                                  hint: Text("Korban Kekerasan"),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedkorban = value;
                                    });
                                  },
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
                              GestureDetector(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Container(
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
                                      enabled: false,
                                      controller: _tanggalPelaporan,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Tanggal Pelaporan',
                                          hintStyle: lightTextStyle.copyWith(
                                              fontSize: 15,
                                              color: greyLightColor)),
                                    ),
                                  )),
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
                                  keyboardType: TextInputType.phone,
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
                                padding: EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(30)),
                                child: DropdownButton<Map>(
                                  // onTap: () async {
                                  //   await fetchDesa(context);
                                  // },
                                  items:
                                      // !_isLoading
                                      //     ?
                                      _desaList.map((value) {
                                    return DropdownMenuItem<Map>(
                                      value: value,
                                      child: Text(value['nama_desa']),
                                    );
                                  }).toList(),
                                  // : <String>['Perempuan', 'Anak'].map((String value) {
                                  //     return DropdownMenuItem<String>(
                                  //       value: value,
                                  //       child: Text(value),
                                  //     );
                                  //   }).toList(),
                                  value: selectedDesa,
                                  isExpanded: true,
                                  underline: Container(),
                                  hint: Text("Pilih Desa"),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedDesa = value;
                                    });
                                  },
                                ),
                              ),
                              // Container(
                              //   padding: EdgeInsets.only(left: 16),
                              //   height: 50,
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(20),
                              //       boxShadow: [
                              //         BoxShadow(
                              //             color: kShadowColor,
                              //             offset: Offset(0, 1),
                              //             blurRadius: 4,
                              //             spreadRadius: 0)
                              //       ],
                              //       color: whiteColor),
                              //   width: MediaQuery.of(context).size.width,
                              //   child: TextField(
                              //     controller: _desaKejadian,
                              //     decoration: InputDecoration(
                              //         border: InputBorder.none,
                              //         hintText: 'Desa Kejadian',
                              //         hintStyle: lightTextStyle.copyWith(
                              //             fontSize: 15, color: greyLightColor)),
                              //   ),
                              // ),
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
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  "Tambahkan Foto Korban",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 15,
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
                                                backgroundImage: FileImage(
                                                    File(image!.path)),
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
                                                          leading: Icon(
                                                              Icons.camera_alt),
                                                          title: Text("Kamera"),
                                                          onTap: () async {
                                                            try {
                                                              var result = await ImageServices
                                                                  .selectImage(
                                                                      isGallery:
                                                                          false);
                                                              if (result !=
                                                                  null) {
                                                                setState(() {
                                                                  image =
                                                                      result;
                                                                });
                                                                print(image!
                                                                    .path);
                                                                print(image!
                                                                    .path
                                                                    .split('/')
                                                                    .last);
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            } catch (e) {
                                                              print(e);
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                          },
                                                        ),
                                                        ListTile(
                                                          leading: Icon(
                                                              Icons.perm_media),
                                                          title: Text("Galeri"),
                                                          onTap: () async {
                                                            try {
                                                              var result = await ImageServices
                                                                  .selectImage(
                                                                      isGallery:
                                                                          true);
                                                              if (result !=
                                                                  null) {
                                                                setState(() {
                                                                  image =
                                                                      result;
                                                                });
                                                                print(image!
                                                                    .path);
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            } catch (e) {
                                                              print(e);
                                                              Navigator.pop(
                                                                  context);
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
                                // margin: EdgeInsets.symmetric(horizontal: 50),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      await _validateAndSubmit(context);
                                    },
                                    child: _isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ))
                                        : Text('Laporkan !',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                    style: ElevatedButton.styleFrom(
                                        primary: yellowColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)))),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        // locale: Locale('id', 'ID'),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  surface: Colors.blue,
                  onSurface: Colors.blue,
                  background: Colors.blue,
                ),
                dialogBackgroundColor: Colors.white),
            child: child!,
          );
        },
        initialDate: pickedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != pickedDate)
      setState(() {
        pickedDate = picked;
        _tanggalPelaporan.text =
            "${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(pickedDate)}";
      });
  }

  List<DropdownMenuItem<Object?>> buildDropdownTestItems(List korban) {
    List<DropdownMenuItem<Object?>> items = [];
    for (var i in korban) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(
            i['value'],
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
    return items;
  }

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
                  if (result != null) {
                    setState(() {
                      image = result;
                    });
                  }
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
