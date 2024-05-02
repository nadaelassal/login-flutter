import 'package:flutter/material.dart';

class Customlogo extends StatelessWidget {
  const Customlogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(70)),
        /*child: Image.asset(
          'images/image-3.png',
          height: 40,
        ),*/
        child: Icon(
          Icons.person_rounded,
          size: 50,
        ),
      ),
    );
  }
}
