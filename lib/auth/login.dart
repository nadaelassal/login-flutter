// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_app/components/custombutton.dart';
import 'package:login_app/components/customlogo.dart';
import '../components/textformfeild.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: ['profile', ' email']).signIn();

    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.all(20),
              child: ListView(children: [
                Form(
                  key: formState,
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
                        "Login",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 10,
                      ),
                      Text(
                        "Login To Continue using the app",
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      Container(
                        height: 30,
                      ),
                      const Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      CustomTextForm(
                          hinttext: "Enter Your Email",
                          mycontroller: email,
                          validator: (val) {
                            if (val == "") {
                              return ("Can't be empty");
                            }
                          }),
                      Container(
                        height: 20,
                      ),
                      const Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      CustomTextForm(
                          hinttext: "Enter Your Password",
                          mycontroller: password,
                          validator: (val) {
                            if (val == "") {
                              return ("Can't be empty");
                            }
                          }),
                      InkWell(
                        onTap: () async {
                          if (email.text == "") {
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
                                      content: Text("Please enter your email"),
                                      title: Text("Alert"),
                                    ));
                            return;
                          }

                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: email.text);
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
                                          "Please go to your email to reset password"),
                                      title: Text("Alert"),
                                    ));
                          } catch (e) {
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
                                      content: Text("User not found"),
                                      title: Text("Alert"),
                                    ));
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 20),
                          alignment: Alignment.topRight,
                          child: const Text(
                            "Forget password ?",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomButton(
                  title: "Login",
                  onPressed: () async {
                    if (formState.currentState!.validate()) {
                      try {
                        isLoading = true;
                        setState(() {});
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email.text, password: password.text);
                        isLoading = false;
                        setState(() {});
                        if (credential.user!.emailVerified) {
                          Navigator.of(context)
                              .pushReplacementNamed("homepage");
                        } else {
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
                                        "Please go to your email to be verified"),
                                    title: Text("Alert"),
                                  ));
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
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
                                        Text("No user found for that email"),
                                    title: Text("Alert"),
                                  ));
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
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
                                        "Wrong password provided for that user"),
                                    title: Text("Alert"),
                                  ));
                          print('Wrong password provided for that user.');
                        }
                      }
                    } else {
                      print("Not valid");
                    }
                  },
                ),
                Container(
                  height: 20,
                ),
                MaterialButton(
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: () {
                    signInWithGoogle();
                  },
                  child: const Text(
                    "Login with Google",
                  ),
                  color: Colors.green,
                  textColor: Colors.white,
                ),
                Container(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("signup");
                  },
                  child: const Center(
                    child: Text.rich(TextSpan(children: [
                      TextSpan(text: "Do not have an accout ?"),
                      TextSpan(
                          text: "Register",
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
