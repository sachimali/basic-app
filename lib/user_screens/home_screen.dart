import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vcomplaint/user_screens/registercomplaint_screen.dart';
import 'package:vcomplaint/user_screens/signin_screen.dart';
import 'package:vcomplaint/user_screens/viewcomplaint_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint Registration'),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: TextButton(
                    child: const Text('Log Out'),
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        // ignore: avoid_print
                        print('Signed Out');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo22.png',
              width: 240.0,
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                // ignore: prefer_const_constructors
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        // ignore: prefer_const_constructors
                        builder: (context) => RegisterComplaintScreen()));
              },
              child: const Text('Register a Complaint'),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        // ignore: prefer_const_constructors
                        builder: (context) => ViewComplaintsScreen()));
              },
              child: const Text('View Complaints'),
            ),
          ],
        ),
      ),
    );
  }
}
