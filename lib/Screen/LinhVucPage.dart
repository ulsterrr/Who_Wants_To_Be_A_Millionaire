import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neon/neon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:who_wants_to_be_a_millionaire/Object/category_obj.dart';
import 'Game_page.dart';
import 'Widget/button.dart';
import 'dart:math';
import 'dart:async';

class LinhVucPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<CategoryObject> lstCategory = [];
  List<String> lsTitle = [
    'Khoa học - kỹ thuật',
    'Phim ảnh',
    'Văn hóa - xã hội',
    'Văn hóa - xã hội',
    'Văn hóa - xã hội',
    'Lịch sử - địa lí'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 150,
                //color: Colors.blueAccent,
                child: Text(
                  textAlign: TextAlign.center,
                  _auth.currentUser!.displayName == null
                      ? 'Người chơi: Username'
                      : 'Người chơi: ' + _auth.currentUser!.displayName!,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
            ],
          ),
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    child: Icon(
                  FontAwesomeIcons.gem,
                  color: Color.fromARGB(255, 240, 170, 78),
                )),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '2000',
                  style: TextStyle(color: Colors.yellowAccent, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
              padding: const EdgeInsets.only(top: 85),
              height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Neon(
                    text: 'Chọn lĩnh vực',
                    color: Colors.red,
                    fontSize: 35,
                    font: NeonFont.NightClub70s,
                    flickeringText: true,
                    flickeringLetters: null,
                    glowingDuration: new Duration(seconds: 1),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: lsTitle.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.fromLTRB(35, 5, 35, 5),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GamePage(category: lstCategory[index],)),
                              );
                            },
                            child: buildButton(
                              context,
                              lsTitle[index],
                            ),
                          ),
                        );
                      }),
                ],
              )),
        ));
  }
}
