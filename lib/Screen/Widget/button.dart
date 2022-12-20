import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:who_wants_to_be_a_millionaire/Provider/authentication.dart';

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

Widget buttonQuiz(BuildContext context, String title) {
  return Container(
    alignment: Alignment.center,
    height: 65,
    width: 320,
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
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget buttonLogout(BuildContext context) {
  return GestureDetector(
    onTap: () {
      FirebaseAuth.instance.signOut();
      GoogleSignIn().signOut();
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    },
    child: Container(
      alignment: Alignment.center,
      height: 50,
      width: 250,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 153, 4, 4),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Padding(
        padding: EdgeInsets.all(9.0),
        child: Text(
          'Đăng xuất',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
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
