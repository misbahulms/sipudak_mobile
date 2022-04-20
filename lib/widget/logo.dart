import 'package:flutter/material.dart';

class LogoSpace extends StatelessWidget {
  const LogoSpace({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset(
            "assets/text_logo.png",
            width: 300,
          ),
          // child ?? SizedBox()
        ],
      ),
    );
  }
}
