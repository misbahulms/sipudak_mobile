import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:sipudak/pages/login.dart';
import 'package:sipudak/services/image_services.dart';
import 'package:sipudak/theme.dart';
import 'package:sipudak/widget/button_primary.dart';
import 'package:sipudak/widget/logo.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:sipudak/widget/my_headerAn.dart';
import 'package:sipudak/widget/my_headerPL.dart';

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

  File? image;

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
                                  backgroundImage: NetworkImage(image!.path),
                                )
                              : CircleAvatar(
                                  radius: 80.0,
                                  backgroundImage: FileImage(File(image!.path)),
                                ))
                          : CircleAvatar(
                              radius: 80.0,
                              backgroundImage: AssetImage("assets/profil.png"),
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
                                                var result = await ImageServices
                                                    .selectImage(
                                                        isGallery: false);
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
                                                var result = await ImageServices
                                                    .selectImage(
                                                        isGallery: true);
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
                ),

                SizedBox(
                  height: 30,
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonPrimary(
                    text: "Laporkan !",
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          )
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
