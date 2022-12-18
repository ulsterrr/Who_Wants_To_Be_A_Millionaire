import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ShowDialog.dart';

@override
Widget buildButton(BuildContext context, String title) {
  return Container(
    alignment: Alignment.center,
    height: 50,
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
      padding: EdgeInsets.all(9.0),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

@override
Widget buildButtonLogin(
  BuildContext context,
  String title,
  String pass,
  String email,
) {
  return GestureDetector(
    onTap: () async {
      try {
        final newUser = FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass);
        FirebaseAuth.instance.authStateChanges().listen((event) {
          if (event != null) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              'home',
              (route) => false,
            );
          } else {
            customDialog(context, 'Đăng nhập thất bại',
                'Email hoặc mật khẩu không đúng', true);
          }
        });
      } catch (e) {
        customDialog(context, 'Đăng nhập thất bại', 'Lỗi kết nối!', true);
      }
    },
    child: Container(
      alignment: Alignment.center,
      height: 60,
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
        padding: EdgeInsets.all(9.0),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
