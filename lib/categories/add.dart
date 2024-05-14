import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/components/custombutton.dart';
import 'package:login_app/components/customtextformfeildadd.dart';

class AddCatigory extends StatefulWidget {
  const AddCatigory({super.key});

  @override
  State<AddCatigory> createState() => _AddCatigoryState();
}

class _AddCatigoryState extends State<AddCatigory> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  addUser() async {
    try {
      DocumentReference response = await categories.add(
          {"name": name.text, "id": FirebaseAuth.instance.currentUser!.uid});
      Navigator.of(context).pushReplacementNamed("homepage");
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _formKey,
        appBar: AppBar(
          title: Text("Add Category"),
        ),
        body: Form(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: CustomTextFormAdd(
                  hinttext: "Enter Name",
                  mycontroller: name,
                  validator: (val) {
                    if (val == " ") {
                      return ("can't be empty");
                    }
                  }),
            ),
            CustomButton(
                title: "Add",
                onPressed: () {
                  addUser();
                }),
          ],
        )));
  }
}
