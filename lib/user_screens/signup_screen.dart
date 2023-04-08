import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // ignore: prefer_final_fields
  TextEditingController _passwordTextController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _emailTextController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColour("3fd15e"),
            hexStringToColour("3fd15e"),
            hexStringToColour("3fd15e")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            // ignore: prefer_const_constructors
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter UserName", Icons.person_outline,
                      false, _userNameTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Email ID", Icons.person_outline,
                      false, _emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Password", Icons.person_outlined,
                      true, _passwordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  signInSignUpButton(context, false, () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      // ignore: avoid_print
                      print("Created New Account");
                      Navigator.push(
                          context,
                          // ignore: prefer_const_constructors
                          MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => HomeScreen()));
                    }).onError((error, stackTrace) {
                      // ignore: avoid_print
                      print("Error ${error.toString()}");
                    });
                  })
                ]),
          ))),
    );
  }
}
