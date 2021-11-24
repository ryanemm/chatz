import 'package:chatz/helper/helper_functions.dart';
import 'package:chatz/screens/chat_room.dart';
import 'package:chatz/screens/home_screen.dart';
import 'package:chatz/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  bool? userIsLoggedIn;

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {});
  }

  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return HomeScreen();
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
    /*return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: SignIn(),
    );*/
  }
}
