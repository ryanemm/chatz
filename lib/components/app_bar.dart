import 'package:flutter/material.dart';

class AppBarChatRoom extends StatefulWidget {
  const AppBarChatRoom({Key? key}) : super(key: key);

  @override
  _AppBarChatRoomState createState() => _AppBarChatRoomState();
}

class _AppBarChatRoomState extends State<AppBarChatRoom> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Row(children: [
        Text("Messages"),
      ]),
    );
  }
}
