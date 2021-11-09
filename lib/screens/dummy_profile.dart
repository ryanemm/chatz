import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSendingVerification = false;
  bool isSigningOut = false;
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
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
    );
  }
}
