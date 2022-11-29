import 'package:flutter/material.dart';

@override
Widget buildButton(BuildContext context, String title) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      alignment: Alignment.center,
      width: 250,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 32, 31, 128),
                Color.fromARGB(255, 20, 133, 148),
                Color.fromARGB(255, 2, 55, 99),
              ])),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
