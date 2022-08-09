import 'package:flutter/material.dart';
import 'package:sipudak/home.dart';
import 'package:sipudak/network/api/url_api.dart';
import 'package:sipudak/pages/register.dart';
import 'package:sipudak/theme.dart';
import 'package:sipudak/widget/button_primary.dart';
import 'package:sipudak/widget/logo.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nomorHpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var whiteColor;
  bool _secureText = true, _isLoading = false;
  var _formKey = GlobalKey<FormState>();
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  void initState() {
    super.initState();

    checkLogin();
  }

  Future checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? nomorHp = prefs.getString('idUser');
    int? idUser = prefs.getInt('nomorHp');
    String? password = prefs.getString('password');

    print("check idUser: $idUser");
    print("check noHp: $nomorHp");
    print("check password: $password");

    if (nomorHp != null && password != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage(idUser: idUser)));
    }
  }

  // final Dio _dio = Dio();

  // Future<Response> Login(String nomorHp, String password) async {
  //   try {
  //     Response response = await _dio.post(
  //         'https://api-sipudak.silogis.net/Login',
  //         data: {'nomorHp': nomorHp, 'password': password});
  //     return response.data;
  //   } on DioError catch (e) {
  //     return e.response!.data;
  //   }
  // }

  Future signIn() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

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

    print(nomorHpController.text);
    print(passwordController.text);

    try {
      var responseData = await dio.post(
        BASEURL.login,
        data: {
          'no_hp': nomorHpController.text,
          'password': passwordController.text
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      // print(Constant.login);

      print("RESPONSE: $responseData");

      if (responseData.data['status']) {
        await Future.wait([
          prefs.setInt('idUser', responseData.data['id']),
          prefs.setString('nomorHp', nomorHpController.text),
          prefs.setString('password', passwordController.text),
        ]);

        setState(() {
          _isLoading = false;
          //if there is no error, get the user's accesstoken and pass it to HomeScreen
          String accessToken = responseData.data['data'];
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${responseData.data['data']}'),
          backgroundColor: Colors.blue.shade300,
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        // notifyListeners();

        print(responseData.data['message']);
      } else {
        setState(() {
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
      print("catch $e");
    }

    // _isLoadingUser = false;
    // notifyListeners();

    // return users;
  }
  // Future<void> login() async {
  //   var _formKey;
  //   if (_formKey.currentState!.validate()) {
  //     //show snackbar to indicate loading
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: const Text('Processing Data'),
  //       backgroundColor: Colors.green.shade300,
  //     ));

  //     //get response from ApiClient
  //     var _apiClient;
  //     dynamic res = await _apiClient.login(
  //       nomorHpController.text,
  //       passwordController.text,
  //     );
  //     ScaffoldMessenger.of(context).hideCurrentSnackBar();

  //     //if there is no error, get the user's accesstoken and pass it to HomeScreen
  //     if (res['ErrorCode'] == null) {
  //       String accessToken = res['access_token'];
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => HomePage()));
  //     } else {
  //       //if an error occurs, show snackbar with error message
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text('Error: ${res['Message']}'),
  //         backgroundColor: Colors.red.shade300,
  //       ));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: 100,
              ),
              Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: regulerTextStyle.copyWith(fontSize: 20),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Silakan Masukan Data Anda",
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
                      child: TextFormField(
                        controller: nomorHpController,
                        validator: (value) {
                          if (value!.length < 9)
                            return "Nomor Hp Anda Minimal 9 Karakter";
                        },
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
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: _secureText,
                        validator: (value) {
                          if (value!.length < 2)
                            return "Password Anda Kurang dari 6 Karakter";
                        },
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
                                await signIn();
                              },
                              child: _isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : Text("Login"),
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
                          "Belum punya akun? ",
                          style: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                          child: const Text('Buat Akun'),
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
