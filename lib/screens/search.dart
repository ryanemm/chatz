import 'package:chatz/components/simple_button.dart';
import 'package:chatz/helper/constants.dart';
import 'package:chatz/screens/conversation_screen.dart';
import 'package:chatz/services/database.dart';
import 'package:chatz/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  void initState() {
    // initiateSearch();
    super.initState();
  }

  QuerySnapshot? searchSnapshot;

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot?.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                userEmail: searchSnapshot?.docs[index]["email"],
                username: searchSnapshot?.docs[index]["name"],
              );
            })
        : Container();
  }

  initiateSearch() {
    databaseMethods
        .getUserByUsername(searchTextEditingController.text)
        .then((val) {
      print(val.toString());
      setState(() {
        searchSnapshot = val;
      });
      return val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search users"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(height: 1),
            GestureDetector(
              onTap: () {
                initiateSearch();
              },
              child: Container(
                color: Colors.grey[300],
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: searchTextEditingController,
                      decoration: InputDecoration(
                          hintText: "Search username",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: InputBorder.none),
                    )),
                    Icon(
                      Icons.search,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
            searchList(),
          ],
        ),
      ),
    );
  }
}

///create a chatroom, send the user to a conversation screen, pushReplacement
createRoomStartConversation({BuildContext context, String username}) {
  String chatRoomId = getChatRoomId(username, Constants.myName);
  List<String?> users = [username, Constants.myName];
  Map<String, dynamic> chatRoomMap = {
    "users": users,
    "chatRoomId": chatRoomId,
  };
  DatabaseMethods().CreateChatRoom(chatRoomId, chatRoomMap);
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ConversationScreen()));
}

class SearchTile extends StatelessWidget {
  final String username;
  final String userEmail;
  const SearchTile({required this.userEmail, required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  userEmail,
                  style: simpleTextStyle(),
                )
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: SimpleButton(
                text: "Message",
                width: 100,
                shadowColor: Colors.transparent,
                padding: 0,
              ),
            )
          ],
        ));
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
