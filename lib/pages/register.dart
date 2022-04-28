import 'dart:convert';
// import 'dart:html';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:sipudak/network/api/url_api.dart';
import 'package:sipudak/pages/login.dart';
import 'package:sipudak/pages/splash_screen.dart';
import 'package:sipudak/theme.dart';
import 'package:sipudak/widget/button_primary.dart';
import 'package:sipudak/widget/logo.dart';
import 'package:http/http.dart' as http;
import 'package:sipudak/home.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nomorHpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool _secureText = true, _isLoading = false;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

//   Future submitForm() async {
//     _formKey.currentState?.save();
//     // var formData = Dio().FormData.fromMap({
//     //   "nama": namaController.text,

//     //   "email": emailController.text,
//     //   "no_hp": nomorHpController.text,
//     //   "alamat": alamatController.text,
//     //   "password": passwordController.text,
//     // });

//     try {

//     var response =
//         await Dio().post(BASEURL.apiRegister, options: Options(), data: {
//       "nama": namaController.text,
//       "email": emailController.text,
//       "no_hp": nomorHpController.text,
//       "alamat": alamatController.text,
//       "password": passwordController.text,
//     });

//     print(response.data);
//     var value = response.data['value'];
//     var message = response.data['message'];
//     if (value == 1) {
//       showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//                 title: Text("Information"),
//                 content: Text(message),
//                 actions: [TextButton(onPressed: () {}, child: Text("Ok"))],
//               ));
//       setState(() {});
//     } else {
//       showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//                 title: Text("Information"),
//                 content: Text(message),
//                 actions: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text("Ok"))
//                 ],
//               ));
//     }
//     setState(() {});

//     } catch(e){
// print("error $e");
//     }}

  Future registerSubmit() async {
    setState(() {
      _isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // if (!_formKey.currentState!.validate()) {
    //   return;
    // }
    // _formKey.currentState?.save();

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
      print({
        "nama": namaController.text,
        "email": emailController.text,
        "no_hp": nomorHpController.text,
        "alamat": alamatController.text,
        "password": passwordController.text,
      });
      var response = await dio.post(BASEURL.register,
          options: Options(contentType: Headers.formUrlEncodedContentType),
          data: FormData.fromMap({
            "nama": namaController.text,
            "email": emailController.text,
            "no_hp": nomorHpController.text,
            "alamat": alamatController.text,
            "password": passwordController.text,
            "is_active": 1,
            "role": "User",
            "date_created": "2022-07-15 00:00:00",
            "image": "graduate-icon-png-28-2.png"
          }));

      final data = response.data;
      print(data);
      var status = data['status'];
      String message = data['message'];
      print(data);

      if (status) {
        await Future.wait([
          prefs.setString('nomorHp', nomorHpController.text),
          prefs.setString('password', passwordController.text),
        ]);
        setState(() {
          _isLoading = false;
        });

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        // showDialog(
        //     context: context,
        //     builder: (context) => AlertDialog(
        //           title: Text("Information"),
        //           content: Text(message),
        //           actions: [TextButton(onPressed: () {}, child: Text("Ok"))],
        //         ));
        // setState(() {});
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Information"),
                  content: Text(message),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Ok"))
                  ],
                ));
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print("eror $e");

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var whiteColor;
    return Scaffold(
      body: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                child: LogoSpace(
                  child: SizedBox(
                    height: 2,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Registrasi",
                      style: regulerTextStyle.copyWith(fontSize: 20),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Silakan Isi Data Anda",
                      style: regulerTextStyle.copyWith(
                          fontSize: 15, color: greyLightColor),
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
                                color: Colors.white,
                                offset: Offset(0, 1),
                                blurRadius: 1,
                                spreadRadius: 0)
                          ],
                          color: whiteColor),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: namaController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nama Lengkap',
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
                                color: Colors.white,
                                offset: Offset(0, 1),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                          color: whiteColor),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
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
                                color: Colors.white,
                                offset: Offset(0, 1),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                          color: whiteColor),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: nomorHpController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nomor Hp',
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
                                color: Colors.white,
                                offset: Offset(0, 1),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                          color: whiteColor),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: alamatController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Alamat',
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
                                color: Colors.white,
                                offset: Offset(0, 1),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                          color: whiteColor),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: passwordController,
                        obscureText: _secureText,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: showHide,
                              icon: _secureText
                                  ? Icon(Icons.visibility_off, size: 20)
                                  : Icon(Icons.visibility, size: 20),
                            ),
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: lightTextStyle.copyWith(
                                fontSize: 15, color: greyLightColor)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (namaController.text.isEmpty ||
                                    emailController.text.isEmpty ||
                                    nomorHpController.text.isEmpty ||
                                    alamatController.text.isEmpty ||
                                    passwordController.text.isEmpty) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text("Warning"),
                                            content: Text(
                                                "Please, enter the fields"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Ok"))
                                            ],
                                          ));
                                } else {
                                  await registerSubmit();
                                  // await submitForm();
                                }
                              },
                              child: _isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : Text("Registrasi"),
                              style: ElevatedButton.styleFrom(
                                  primary: yellowColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sudah punya akun? ",
                          style: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor),
                        ),
                        TextButton(    
                          style: TextButton.styleFrom(
                            primary: blueColor,
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text('Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
