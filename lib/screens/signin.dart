import 'package:chatz/components/image_button.dart';
import 'package:chatz/components/simple_button.dart';
import 'package:chatz/screens/chat_room.dart';
import 'package:chatz/screens/dummy_profile.dart';
import 'package:chatz/screens/signup.dart';
import 'package:chatz/services/auth.dart';
import 'package:chatz/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class SignIn extends StatefulWidget {
//  final Function toggle;
  //SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //set the default state of _initialized and _error to false
  bool _initialized = false;
  bool _error = false;

  // async function to initialize firebase
  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ChatRoom(user: user)));
      }
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthService authService = new AuthService();
    TextEditingController _emailEditingController = new TextEditingController();
    TextEditingController _passwordEditingController =
        new TextEditingController();

    signIn() async {
      if (_formKey.currentState!.validate()) {
        await authService
            .signInWithEmailAndPassword(
                _emailEditingController.text, _passwordEditingController.text)
            .then((user) {
          if (user != null) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ChatRoom(user: user)));
          }
        });
      }
    }

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

    return Scaffold(
      body: Container(
        color: Colors.grey[50],
        child: Stack(children: [
          Container(
            color: Color(0xffFFFDD1).withOpacity(0.2),
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Spacer(),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(4, 7),
                                color: Colors.grey.shade200,
                                blurRadius: 20),
                          ]),
                      child: TextFormField(
                        controller: _emailEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration(
                            "Email",
                            Icon(
                              Icons.email_outlined,
                              color: Colors.purple,
                            )),
                      ),
                    ),
                    SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(4, 7),
                                color: Colors.grey.shade200,
                                blurRadius: 20),
                          ]),
                      child: TextFormField(
                        controller: _passwordEditingController,
                        obscureText: true,
                        validator: (val) {
                          return val!.length > 8
                              ? null
                              : "Password must have 8 characters or more";
                        },
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration(
                            "Password",
                            Icon(
                              Icons.lock_outline,
                              color: Colors.purple,
                            )),
                      ),
                    )
                  ]),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "Forgot password?",
                        style: simpleTextStyle(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    signIn();
                  },
                  child: ImageButton(
                    buttonColor1: Colors.indigo.shade900,
                    buttonColor2: Colors.purple,
                    shadowColor: Colors.grey.shade600,
                    offsetX: 4,
                    offsetY: 7,
                    text: "Sign In",
                    width: double.infinity,
                    iconImage: Image.asset(
                      "assets/images/sign_in_icon.png",
                      height: 25,
                    ),
                  ),
                ),
                SizedBox(height: 22),
                ImageButton(
                  buttonColor2: Colors.white,
                  buttonColor1: Colors.white,
                  shadowColor: Colors.grey.shade300,
                  offsetX: 4,
                  offsetY: 7,
                  text: "Sign In with Google",
                  width: double.infinity,
                  textColor: Colors.black,
                  iconImage: Image.asset(
                    "assets/images/google_icon.png",
                    height: 25,
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?  ", style: simpleTextStyle()),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text("Register Now",
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 16,
                              decoration: TextDecoration.underline)),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          Positioned(
            left: -100,
            top: -150,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(175)),
                  color: Color(0xff7921B1).withOpacity(0.9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: Offset(4, 4),
                      blurRadius: 40,
                    )
                  ]),
            ),
          ),
          Positioned(
            right: -120,
            top: 100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Color(0xffD7A1F9),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: Offset(4, 5),
                        blurRadius: 40)
                  ]),
            ),
          )
        ]),
      ),
    );
  }
}
