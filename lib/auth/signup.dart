// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/custombutton.dart';
import '../components/customlogo.dart';
import '../components/textformfeild.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                ),
                Customlogo(),
                Container(
                  height: 20,
                ),
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 10,
                ),
                Text(
                  "Signup To Continue using the app",
                  style: TextStyle(color: Colors.grey[400]),
                ),
                Container(
                  height: 30,
                ),
                const Text(
                  "Username",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                CustomTextForm(
                  hinttext: "Enter Your Username",
                  mycontroller: username,
                ),
                Container(
                  height: 20,
                ),
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                CustomTextForm(
                  hinttext: "Enter Your Email",
                  mycontroller: email,
                ),
                Container(
                  height: 20,
                ),
                const Text(
                  "Password",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                CustomTextForm(
                  hinttext: "Enter Your Password",
                  mycontroller: password,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  alignment: Alignment.topRight,
                  child: const Text(
                    "Forget password ?",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          CustomButton(
              title: "Signup",
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email.text,
                    password: password.text,
                  );
                  Navigator.of(context).pushReplacementNamed("homepage");
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Close"))
                              ],
                              content:
                                  Text("The password provided is too weak"),
                              title: Text("Alert"),
                            ));
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Close"))
                              ],
                              content: Text(
                                  "The account already exists for that email"),
                              title: Text("Alert"),
                            ));
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              }),
          Container(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed("login");
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(text: "Do you have an accout ?"),
                TextSpan(
                    text: "Login",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))
              ])),
            ),
          ),
        ]),
      ),
    );
  }
}
