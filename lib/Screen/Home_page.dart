import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:who_wants_to_be_a_millionaire/Screen/Widget/button.dart';
import 'package:who_wants_to_be_a_millionaire/Screen/profile_page.dart';

import 'Credit_page.dart';
import 'History_page.dart';
import 'LinhVucPage.dart';
import 'Signup_page.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromARGB(255, 2, 1, 71),
                Colors.cyan,
                Color.fromARGB(255, 1, 25, 44),
              ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.1,
              ),
              Container(
                width: size.width * 0.8,
                height: size.height * 0.65,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(_auth
                                  .currentUser!.photoURL ==
                              null
                          ? 'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'
                          : _auth.currentUser!.photoURL!),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _auth.currentUser!.displayName == null
                              ? 'Username'
                              : _auth.currentUser!.displayName!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 16, 64, 148)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.gem,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              ' 2000',
                              style: TextStyle(
                                color: Colors.orangeAccent,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()),
                        );
                      },
                      child: buildButton(context, 'Quản lý tài khoản'),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LinhVuc()),
                        );
                      },
                      child: buildButton(context, 'Trò chơi mới'),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryPage()),
                        );
                      },
                      child: buildButton(context, 'Lịch sử chơi'),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryPage()),
                        );
                      },
                      child: buildButton(context, 'Xem xếp hạng'),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreditPage()),
                        );
                      },
                      child: buildButton(context, 'Mua Credit'),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    buttonLogout(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
