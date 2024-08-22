import 'package:flutter/material.dart';
import 'package:vcomplaint/admin_screen/adminlogin_screen.dart';
import 'package:vcomplaint/user_screens/signup_screen.dart';
//import 'package:vcomplaint/utils/color_utils.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white, // Set the background color to white
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: logoWidget("assets/images/atharva.png", width: 399),
                ),
                const SizedBox(height: 30),
                reusableTextField("Enter Email", Icons.verified_user, false,
                    _emailTextController),
                const SizedBox(height: 20),
                reusableTextField("Enter Password", Icons.lock_clock_outlined,
                    true, _passwordTextController),
                const SizedBox(height: 20),
                signInSignUpButton(context, true, () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text,
                  )
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Successfully logged in!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }).onError((error, stackTrace) {
                    // ignore: avoid_print
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption(),
                admminsignin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.black), // Change text color to black
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.blue, // Change text color to blue
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Row admminsignin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Admin Sign in is Here ",
          style: TextStyle(color: Colors.black),
        ), // Change text color to black
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminLoginScreen()));
            },
            child: const Text(
              "Sign In",
              style: TextStyle(
                color: Colors.blue, // Change text color to blue
                fontWeight: FontWeight.bold,
              ),
            ))
      ],
    );
  }

  TextFormField reusableTextField(String hintText, IconData icon,
      bool isPassword, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          icon,
          color: Colors.black, // Change icon color to black
        ),
        filled: true,
        fillColor: Colors.white, // Set the text field background color to white
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
