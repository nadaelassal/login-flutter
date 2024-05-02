// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_app/auth/login.dart';
import 'package:login_app/auth/signup.dart';
import 'package:login_app/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyBQUZoLmSEKrb2XSQAEx9sHWBLXDNIO118",
            appId: "1:620879359980:android:bbf95950b40d0845a45ac9",
            messagingSenderId: "620879359980",
            projectId: "login-af5f7",
          ),
        )
      : await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('------> User is currently signed out!');
      } else {
        print('----------> User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? Homepage()
          : Login(),
      routes: {
        "signup": (context) => Signup(),
        "login": (context) => Login(),
        "homepage": (context) => Homepage()
      },
    );
  }
}
