import 'package:chatz/services/database.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key, required this.chatRoomId})
      : super(key: key);
  final String chatRoomId;

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageTextEditingController =
      new TextEditingController();
  // Widget ChatMessageList() {

  // }

  sendMessage() {
    if (messageTextEditingController.text.isNotEmpty) {
      Map<String, String> messageMap = {
        "message": messageTextEditingController.text,
        "sentBy": Constants.myName!
      };
      databaseMethods.getCoversationMessages(widget.chatRoomId, messageMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversation"),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.grey[300],
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageTextEditingController,
                      decoration: InputDecoration(
                          hintText: "Type a message...",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: InputBorder.none),
                    )),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Icon(
                        Icons.send,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
