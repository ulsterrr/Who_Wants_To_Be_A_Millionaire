import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:who_wants_to_be_a_millionaire/Screen/EndGame_page.dart';
import 'package:who_wants_to_be_a_millionaire/Screen/Home_page.dart';
import 'package:who_wants_to_be_a_millionaire/Screen/Login_page.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? 'login' : 'home',
      routes: {
        'login': (context) => LoginPage(),
        'home': (context) => Home(),
        'end': (context) => EndGame(),
      },
    );
  }
}
