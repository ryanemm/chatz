import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return Container(
    child: AppBar(
      title: Text("Chatz"),
      elevation: 0,
      centerTitle: false,
    ),
  );
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 16);
}

InputDecoration textFieldInputDecoration(String hintText, Icon prefixIcon) {
  return InputDecoration(
      hintText: hintText,
      prefixIcon: prefixIcon,
      hintStyle: TextStyle(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(30))));
}
