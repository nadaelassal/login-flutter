import 'package:flutter/material.dart';
import 'package:login_app/components/custombutton.dart';
import 'package:login_app/components/customtextformfeildadd.dart';

class AddCatigory extends StatefulWidget {
  const AddCatigory({super.key});

  @override
  State<AddCatigory> createState() => _AddCatigoryState();
}

class _AddCatigoryState extends State<AddCatigory> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: formstate,
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
              onPressed: () {},
            ),
          ],
        )));
  }
}
