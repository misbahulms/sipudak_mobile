import 'package:flutter/material.dart';
import 'package:sipudak/theme.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final onTap;

  const ButtonPrimary({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 50,
      child: ElevatedButton(
          onPressed: onTap,
          child: Text(text),
          style: ElevatedButton.styleFrom(
              primary: yellowColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)))),
    );
  }
}
