import 'package:chatz/screens/constants.dart';
import 'package:chatz/helper/helper_functions.dart';
import 'package:chatz/screens/conversation_screen.dart';
import 'package:chatz/screens/search.dart';
import 'package:chatz/screens/signin.dart';
import 'package:chatz/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatRoom extends StatefulWidget {
  final User user;
  const ChatRoom({required this.user});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late User _currentUser;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  // Constants constants = new Constants();
  Stream? chatRoomsStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return ChatRoomTile(
                  userName: snapshot.data.docs[index]["chatRoomId"]
                      .toString()
                      .replaceAll("_", "")
                      .replaceAll(Constants.myName.toString(), ""),
                  chatRoomId: snapshot.data.docs[index]["chatRoomId"],
                  // lastMessage: snapshot.data.docs[index]["message"],
                );
              });
        }
      },
    );
  }

  @override
  void initState() {
    _currentUser = widget.user;
    // Constants.myName = _currentUser.displayName;
    getUserInfo();

    super.initState();
  }

  getUserInfo() async {
    Constants.myName = (await HelperFunctions.getUsernameSharedPreference());
    print(Constants.myName);

    databaseMethods.getChatsList(Constants.myName).then((val) {
      setState(() {
        chatRoomsStream = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Constants.myName = _currentUser.displayName;

    Constants.myName != null
        ? print("@ chatRoom " + Constants.myName!)
        : print("Not assigned");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        title: Text(
          "Messages (3)",
          style: GoogleFonts.nunito(fontWeight: FontWeight.w600),
        ),
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
          Colors.indigo.shade900,
          Colors.purple,
        ]))),
        actions: [
          GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignIn()));
              },
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.search),
              ))),
          GestureDetector(
              onTap: () async {},
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.more_vert))))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_rounded), label: "Messages"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_rounded), label: "Notifications"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded), label: "Settings")
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            Future.delayed(Duration.zero, () {
              Navigator.push((context),
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            });
          }),*/
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.indigo.shade900,
          Colors.purple,
        ])),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 4,
                            offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.grey[200]),
                  child: TextField(
                    // controller: searchTextEditingController,

                    decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: "Search users",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: InputBorder.none),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text("Messages",
                      style: GoogleFonts.nunito(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                ),
                chatRoomList(),
              ],
            )
            /*Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("NAME: ${_currentUser.displayName}"),
                SizedBox(height: 16),
                Text("EMAIL: ${_currentUser.email}"),
                SizedBox(height: 16),
                _currentUser.emailVerified
                    ? Text("Email verified")
                    : Text("Email not verified"),
              ],
            ),
          ),*/
            ),
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  const ChatRoomTile({
    Key? key,
    required this.userName,
    required this.chatRoomId,
    // required this.lastMessage
  }) : super(key: key);
  final String userName;
  final String chatRoomId;
  // final String lastMessage;

  @override
  Widget build(BuildContext context) {
    Stream? messagesStream;
    DatabaseMethods _databaseMethods = new DatabaseMethods();
    _databaseMethods.getConversationMessages(chatRoomId).then((val) {
      messagesStream = val;
    });
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(
                      chatRoomId: chatRoomId,
                    )));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(60)),
              child: Text(
                "${userName.substring(0, 1).toUpperCase()}",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: Colors.white),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: GoogleFonts.nunito(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  // Text(lastMessage)
                  Text(
                    "This is the last message that was sent in this chat. Let's make it longer to see if the overflow parameter does its job",
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunito(
                        color: Colors.grey[700], fontSize: 14),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
