import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neon/neon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:who_wants_to_be_a_millionaire/Object/category_obj.dart';
import 'package:who_wants_to_be_a_millionaire/Object/quiz_obj.dart';
import 'package:who_wants_to_be_a_millionaire/Provider/firestore_provider.dart';
import 'Game_page.dart';
import 'Widget/button.dart';
import 'dart:math';
import 'dart:async';

class LinhVuc extends StatefulWidget {
  List<CategoryObject> Category;
  int credit;
  LinhVuc({required this.Category, required this.credit});

  @override
  State<StatefulWidget> createState() { return LinhVucPage(); }
}

class LinhVucPage extends State<LinhVuc> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<QuizObject> lstQuiz = [];

  Future<void> getLstQuiz(int id) async {
    final data = await FireStoreProvider.getCauHoiLV(id);
    lstQuiz = data;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      
    });
  }

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
                width: 180,
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
                  this.widget.credit.toString(),
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
                      itemCount: this.widget.Category.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.fromLTRB(35, 5, 35, 5),
                          child: GestureDetector(
                            onTap: () async{
                              // gán rỗng cho mảng câu hỏi để load page ko bị trùng data khi chưa get kịp
                              lstQuiz = [];
                              // dùng then để nhận biết load xong data thì chuyển sang màn hình khác
                              getLstQuiz(this.widget.Category[index].id).then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GamePage(quiz: lstQuiz, credit: this.widget.credit,)),
                              ));
                            },
                            child: buildButton(
                              context,
                              this.widget.Category[index].categoryName,
                            ),
                          ),
                        );
                      }),
                ],
              )),
        ));
  }
}
