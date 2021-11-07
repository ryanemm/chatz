import 'package:chatz/components/image_button.dart';
import 'package:chatz/components/simple_button.dart';
import 'package:chatz/widgets/widgets.dart';
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class SignUp extends StatefulWidget {
//  final Function toggle;
  //SignIn(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailEditingController = new TextEditingController();
    TextEditingController passwordEditingController =
        new TextEditingController();
    TextEditingController usernameEditingController =
        new TextEditingController();
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
                        controller: usernameEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration(
                            "Username",
                            Icon(
                              Icons.account_circle_outlined,
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
                        controller: emailEditingController,
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
                        controller: passwordEditingController,
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
                              Icons.lock_outline_rounded,
                              color: Colors.purple,
                            )),
                      ),
                    )
                  ]),
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
                    text: "Sign Up",
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
