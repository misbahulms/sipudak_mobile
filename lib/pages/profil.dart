import 'package:flutter/material.dart';
import 'package:sipudak/theme.dart';
import 'package:sipudak/widget/button_primary.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import '../network/api/url_api.dart';

import './login.dart';

// class Profil extends StatefulWidget {
//   const Profil({Key? key}) : super(key: key);

//   @override
//   _ProfilState createState() => _ProfilState();
// }

// class _ProfilState extends State<Profil> {
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//         appBar: AppBar(
//       backgroundColor: yellowColor,
//       centerTitle: true,
//       title: Text("Profil"),
//       actions: <Widget>[
//         FlatButton(
//           onPressed: () {},
//           child: Text(
//             "Edit",
//             style: TextStyle(color: Colors.white),
//           ),
//         )
//       ],
//     ));
//   }
// }

// Widget myProfil() => CircleAvatar(
//       backgroundColor: Colors.grey.shade800,
//       backgroundImage: AssetImage('assets/profil.png'),
//     );

// class Profil extends StatelessWidget {
//   const Profil({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: yellowColor,
//         centerTitle: true,
//         title: Text("Profil"),
//         actions: <Widget>[
//           FlatButton(
//             onPressed: () {},
//             child: Text(
//               "edit",
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class Profil extends StatefulWidget {
  final idUser;
  Profil({Key? key, this.idUser}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  bool _isLoading = false;
  var _data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfil();
  }

  Future getProfil() async {
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
        "${BASEURL.profil}/${widget.idUser}",
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      final data = response.data;
      var status = response.statusCode;
      // String message = data['message'];
      print(data);

      if (status == 200) {
        setState(() {
          _isLoading = false;
          _data = data;
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async => await getProfil(),
      child: ListView(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                color: yellowColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.notifications))),
                  SizedBox(
                    height: 15,
                  ),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Center(
                          child: Column(
                          children: <Widget>[
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("assets/profil.png"))),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${_data['nama']}",
                              style: kTitleTextstyle.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ))
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(20),
            child: Container(
                child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Email",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(_data == null ? "" : _data['email']),
                  leading: Icon(Icons.email),
                ),
                ListTile(
                  title: Text(
                    "Nomor Hp",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(_data == null ? "" : _data['no_hp']),
                  leading: Icon(Icons.phone),
                ),
                ListTile(
                  title: Text(
                    "Alamat",
                    style: boldTextStyle,
                  ),
                  subtitle: Text(_data == null ? "" : _data['alamat']),
                  leading: Icon(Icons.location_on),
                ),
              ],
            )),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            margin: EdgeInsets.only(left: 150, right: 150),
            width: 100,
            child: ButtonPrimary(
              text: "Logout",
              onTap: () async {
                await removePrefs().then((_) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }

  Future removePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
