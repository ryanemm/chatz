import 'package:chatz/components/image_button.dart';
import 'package:chatz/components/simple_button.dart';
import 'package:chatz/widgets/widgets.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class SignIn extends StatefulWidget {
//  final Function toggle;
  //SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purple,
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Spacer(),
                Form(
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
                              Icons.lock,
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
                  onTap: () {},
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
                    Text("Register Now",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 16,
                            decoration: TextDecoration.underline))
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
