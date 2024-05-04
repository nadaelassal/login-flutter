import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();
                googleSignIn.disconnect();
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
        backgroundColor: Colors.blue,
        title: Text(
          "Login Ui",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          FirebaseAuth.instance.currentUser!.emailVerified
              ? Text("Welcom")
              : MaterialButton(
                  onPressed: () {
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                  },
                  child: Text("please verify your email"),
                )
        ],
      ),
    );
  }
}
