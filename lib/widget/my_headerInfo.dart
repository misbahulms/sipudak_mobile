import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:sipudak/pages/beranda.dart';
import 'package:sipudak/theme.dart';

class MyHeaderInfo extends StatelessWidget {
  final String image;
  final String texttop;
  final String textbottom;
  const MyHeaderInfo({
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
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(
          color: yellowColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => Beranda(),
                      //     ));
                    },
                    icon: Icon(Icons.arrow_back_outlined),
                    color: Colors.white,
                    iconSize: 30)),
            SizedBox(
              height: 15,
            ),
            Expanded(
                child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Image.asset(
                    image,
                    width: 200,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                Positioned(
                    top: 60,
                    left: 250,
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
