import 'package:flutter/material.dart';
import 'package:sipudak/theme.dart';

class WidgetLogo extends StatelessWidget {
  const WidgetLogo(
      {Key? key,
      required this.child,
      required this.image,
      required this.title,
      required this.subtitle1,
      required this.subtitle2})
      : super(key: key);
  final Widget child;
  final String image;
  final String title;
  final String subtitle1;
  final String subtitle2;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: 200,
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          title,
          style: regulerTextStyle.copyWith(fontSize: 25),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              subtitle1,
              style: regulerTextStyle.copyWith(
                  fontSize: 20, color: greyLightColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              subtitle2,
              style: regulerTextStyle.copyWith(
                  fontSize: 20, color: greyLightColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            //  SizedBox()
          ],
        )
      ],
    ));
  }
}
