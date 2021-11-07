import 'package:chatz/screens/signin.dart';
import 'package:chatz/screens/signup.dart';
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
  //set the default state of _initialized and _error to false
  bool _initialized = false;
  bool _error = false;

  // async function to initialize firebase
  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // set error state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    if (_error) {
      return Container(
        child: Center(
          child: Text("Something went wrong"),
        ),
      );
    }

    if (!_initialized) {
      return Container(
        child: CircularProgressIndicator(
          semanticsLabel: "Initializing Firebase",
        ),
      );
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: SignIn(),
    );
  }
}
