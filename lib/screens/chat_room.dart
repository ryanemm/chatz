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
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return ChatRoomTile(
                  userName: snapshot.data.docs[index]["chatRoomId"]
                      .toString()
                      .replaceAll("_", "")
                      .replaceAll(Constants.myName.toString(), ""),
                  chatRoomId: snapshot.data.docs[index]["chatRoomId"],
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
        title: Text("Chatz"),
        actions: [
          GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignIn()));
              },
              child: Center(child: Text("Sign Out")))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            Future.delayed(Duration.zero, () {
              Navigator.push((context),
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            });
          }),
      body: Container(child: chatRoomList()
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
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  const ChatRoomTile(
      {Key? key, required this.userName, required this.chatRoomId})
      : super(key: key);
  final String userName;
  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
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
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "This is the last message that was sent in this chat. Let's make it longer to see if the overflow parameter does its job",
                    maxLines: 2,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
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
