import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    Key? key,
    this.text = "Button",
    this.ftSize = 16.0,
    this.buttonColor = Colors.blue,
    this.textColor = Colors.white,
    this.padding = 20.0,
    this.buttonColor1 = Colors.purple,
    this.buttonColor2 = Colors.blue,
    this.shadowColor = Colors.blue,
    this.offsetX = 4,
    this.offsetY = 7,
    this.width = double.minPositive,
  }) : super(key: key);

  final String text;
  final double ftSize;
  final Color buttonColor;
  final Color textColor;
  final double padding;
  final Color buttonColor1;
  final Color buttonColor2;
  final Color shadowColor;
  final double offsetY;
  final double offsetX;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: padding),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: Offset(offsetX, offsetY),
              color: shadowColor,
              blurRadius: 15,
              spreadRadius: 0)
        ],
        gradient: LinearGradient(colors: [buttonColor1, buttonColor2]),
        borderRadius: BorderRadius.circular(40),
      ),
      child: (TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.nunito(
                  fontSize: ftSize,
                  fontWeight: FontWeight.w500,
                  color: textColor),
            ),
          ],
        ),
        onPressed: () {},
      )),
    );
  }
}
