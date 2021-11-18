import 'package:chatz/screens/constants.dart';
import 'package:chatz/helper/helper_functions.dart';
import 'package:chatz/screens/search.dart';
import 'package:chatz/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  final User user;
  const ChatRoom({required this.user});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  late User _currentUser;
  // Constants constants = new Constants();
  @override
  void initState() {
    _currentUser = widget.user;
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = (await HelperFunctions.getUsernameSharedPreference());
  }

  @override
  Widget build(BuildContext context) {
    // print("@ chatRoom " + Constants.myName!);
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
      body: Container(
        child: Center(
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
        ),
      ),
    );
  }
}
