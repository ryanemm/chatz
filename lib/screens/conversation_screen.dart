import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  // Widget ChatMessageList() {

  // }
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
                      // controller: searchTextEditingController,
                      decoration: InputDecoration(
                          hintText: "Type a message...",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: InputBorder.none),
                    )),
                    GestureDetector(
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
