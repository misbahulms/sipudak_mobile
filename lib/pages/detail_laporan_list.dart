import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:sipudak/pages/login.dart';
import 'package:sipudak/services/image_services.dart';
import 'package:intl/intl.dart';
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

class DetailLaporanList extends StatefulWidget {
  Map data;
  DetailLaporanList({Key? key, required this.data}) : super(key: key);

  @override
  _DetailLaporanListState createState() => _DetailLaporanListState();
}

class _DetailLaporanListState extends State<DetailLaporanList> {
  bool _isLoading = false;

  File? image;
  var _korbanKekerasan = TextEditingController();
  var _tempatKejadian = TextEditingController();
  var _alamatKejadian = TextEditingController();
  var _hubunganDgnKorban = TextEditingController();
  var _tanggalDetailLaporanList = TextEditingController();
  var _alamatPelapor = TextEditingController();
  var _nomorHp = TextEditingController();
  var _desaKejadian = TextEditingController();
  var _kronologisKejadian = TextEditingController();
  bool _secureText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _korbanKekerasan.text =
        "Korban Kekerasan:  ${widget.data['korban_kekerasan']}";
    _tempatKejadian.text =
        "Tempat Kejadian:  ${widget.data['tempat_kejadian']}";
    _alamatKejadian.text =
        "Alamat Kejadian:  ${widget.data['alamat_kejadian']}";
    _hubunganDgnKorban.text =
        "Hubungan dengan Korban:  ${widget.data['hubungan_dengan_korban']}";
    _tanggalDetailLaporanList.text =
        "Tanggal: '${DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.parse('${widget.data['tanggal_pelaporan']}'))}";
    _alamatPelapor.text = "Alamat Pelapor:  ${widget.data['alamat_pelapor']}";
    _nomorHp.text = "Nomor HP:  ${widget.data['no_hp']}";
    _desaKejadian.text = "Desa Kejadian:  ${widget.data['id_desa']}";
    _kronologisKejadian.text =
        "Kronologis Kejadian:  ${widget.data['kronologis_kejadian']}";
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  Future _validateAndSubmit(BuildContext context) async {
    if (_korbanKekerasan.text.isEmpty &&
        _tempatKejadian.text.isEmpty &&
        _alamatKejadian.text.isEmpty &&
        _hubunganDgnKorban.text.isEmpty &&
        _tanggalDetailLaporanList.text.isEmpty &&
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
    print({
      // 'id_pelapor': "1",
      'id_user': "1",
      'alamat_pelapor': _alamatPelapor.text,
      'no_hp': _nomorHp.text,
      'korban_kekerasan': _korbanKekerasan.text,
      'tanggal_DetailLaporanList': "2021-07-15 00:00:00",
      'tempat_kejadian': _tempatKejadian.text,
      'alamat_kejadian': _alamatKejadian.text,
      'kronologis_kejadian': _kronologisKejadian.text,
      'image': "graduate-icon-png-28-2.png",
      'id_status': "2",
      'hubungan_dengan_korban': _hubunganDgnKorban.text,
      'id_desa': "1",
      'date_created': '24'
      // 'date_created': "2022-07:15 00:00:00",
    });
    try {
      var responseData = await dio.post(
        BASEURL.pelaporan,
        data: FormData.fromMap({
          'id_user': "3",
          'alamat_pelapor': _alamatPelapor.text,
          'no_hp': _nomorHp.text,
          'korban_kekerasan': _korbanKekerasan.text,
          'tanggal_DetailLaporanList': "2021-07-15 00:00:00",
          'tempat_kejadian': _tempatKejadian.text,
          'alamat_kejadian': _alamatKejadian.text,
          'kronologis_kejadian': _kronologisKejadian.text,
          'image': await MultipartFile.fromFile(image!.path,
              filename: image!.path.split('/').last),
          'id_status': "1",
          'hubungan_dengan_korban': _hubunganDgnKorban.text,
          'id_desa': "190",
          'date_created': "2022-07:15 00:00:00",
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
                      "Detail Laporan",
                      style: regulerTextStyle.copyWith(fontSize: 20),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Berikut adalah detail laporan",
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
                        enabled: false,
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
                        enabled: false,
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
                        enabled: false,
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
                        enabled: false,
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
                        enabled: false,
                        controller: _tanggalDetailLaporanList,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tanggal DetailLaporanList',
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
                        enabled: false,
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
                        enabled: false,
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
                            enabled: false,
                            hintStyle: lightTextStyle.copyWith(
                                fontSize: 15, color: greyLightColor)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 16),
                      height: 200,
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
                        maxLines: 5,
                        controller: _kronologisKejadian,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Kronologis Kejadian',
                            enabled: false,
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

                                                      Navigator.pop(context);
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
                                  borderRadius: BorderRadius.circular(20)))),
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
