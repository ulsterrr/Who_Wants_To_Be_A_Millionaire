import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neon/neon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:who_wants_to_be_a_millionaire/Object/category_obj.dart';
import 'package:who_wants_to_be_a_millionaire/Object/quiz_obj.dart';
import 'package:who_wants_to_be_a_millionaire/Provider/firestore_provider.dart';
import 'package:who_wants_to_be_a_millionaire/Screen/timebar_for_question.dart';

import 'button.dart';
import 'dart:async';

class GamePage extends StatefulWidget {
  CategoryObject category;
  GamePage({Key? key, required this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GamePageState();
  }
}

class GamePageState extends State<GamePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<QuizObject> quiz = [];

  void getLstCauHoi() async {
    final data = await FireStoreProvider.getCauHoiLV(this.widget.category.id);
    setState(() {});
    quiz = data;
  }

  @override
  void initState() {
    super.initState();
    getLstCauHoi();
  }

  List<String> lsTitle = [
    'Tài nguyên giữ vị trí quan trọng nhất Việt Nam hiện nay là:',
    'Tài nguyên đất',
    'Tài nguyên sinh vật',
    'Tài nguyên nước',
    'Tài nguyên khoáng sản',
    'Tài nguyên đất'
  ];

  Timer? timer;
  Timer? timer2;
  int number = 1;
  int score = 0;
  var scores = [
    200,
    400,
    600,
    1000,
    2000,
    3000,
    6000,
    10000,
    14000,
    22000,
    30000,
    40000,
    60000,
    85000,
    150000
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 180,
              color: Colors.blueAccent,
              child: Text(
                _auth.currentUser!.displayName == null
                    ? 'Username'
                    : _auth.currentUser!.displayName!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 16, 64, 148)),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              child: Text(
                '2000',
                style: TextStyle(color: Colors.yellowAccent),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
                child: Icon(
              FontAwesomeIcons.gem,
              color: Color.fromARGB(255, 240, 170, 78),
            )),
          ],
        ),
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
              children: [
                const SizedBox(
                  height: 86,
                ),
                CustomTimer(quizz: quiz[0],leftSeconds: 20),
                Neon(
                  text: 'Điểm : 0',
                  color: Colors.red,
                  fontSize: 35,
                  font: NeonFont.NightClub70s,
                  flickeringText: true,
                  flickeringLetters: null,
                  glowingDuration: new Duration(seconds: 1),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Câu hỏi',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Text(
                    '1',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: 275,
                  alignment: Alignment.center,
                  child: Text(quiz[1].question,
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: buildButton(context, quiz[1].quizAns1),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: buildButton(context, quiz[1].quizAns2),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: buildButton(context, quiz[1].quizAns3),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: buildButton(context, quiz[1].quizAns4),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.phone,
                            color: Colors.white)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.bar_chart,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.refresh_outlined,
                          color: Colors.white,
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          '50:50',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
