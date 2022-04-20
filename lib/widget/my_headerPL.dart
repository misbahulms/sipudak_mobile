import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:sipudak/pages/beranda.dart';
import 'package:sipudak/pages/info_screen.dart';
import 'package:sipudak/theme.dart';

class MyHeaderPL extends StatelessWidget {
  final String image;
  final String texttop;
  final String textbottom;
  const MyHeaderPL({
    Key? key,
    required this.image,
    required this.texttop,
    required this.textbottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
          color: blueColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoScreen(),
                          ));
                    },
                    icon: Icon(Icons.arrow_back_outlined),
                    color: Colors.white,
                    iconSize: 30)),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 90,
                    child: Text(
                      "$texttop \n$textbottom",
                      style: boldTextStyle.copyWith(
                          color: Colors.white, fontSize: 15),
                    )),
                Container(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 5);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 5);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
