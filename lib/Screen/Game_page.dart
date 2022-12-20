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
import 'dart:math';

class GamePage extends StatefulWidget {
  List<QuizObject> quiz;
  GamePage({Key? key, required this.quiz}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GamePageState();
  }
}

class GamePageState extends State<GamePage> {
  // declare some variable
  Random rd = new Random();
  Timer? timer;
  Timer? timer2;
  int number = 1;
  var answer = List.filled(4, "");
  var height = List.filled(4, 0.0);
  bool used = false;
  bool checkChose = false;
  bool skip = false;
  List<Color> colors = List.filled(4, Colors.black);
  //icon quyền trợ giúp
  List<String> imgName = ["5050.png", "call.png", "helpme.png", "skip.png"];
  //declare data
  final FirebaseAuth _auth = FirebaseAuth.instance;
  QuizObject onequiz = new QuizObject();
  //thang điểm
  int score = 0;
  var scores = [
    200,
    500,
    1000,
    2000,
    10000,
    20000,
    30000,
    50000,
    100000,
    150000
  ];

  @override
  void dispose() {
    super.dispose();
    //_controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    Next();
  }

  int count = 0;
  void Gogame() {
    count = onequiz.manyTime;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (count > 0) {
        setState(() {
          count--;
        });
      } else {
        timer.cancel();
        EndGame();
      }
    });
  }

  void Next() async {
    checkChose = false;
    used = false;
    timer?.cancel();
    height = List.filled(4, 0.0);
    //answer = List.filled(4, "");
    Random rdonequiz = new Random();
    int location = 0;
    if (this.widget.quiz.length > 0) {
      int location = rdonequiz.nextInt(this.widget.quiz.length);
      onequiz = this.widget.quiz[location];
      var temp = [
        onequiz.quizAns1,
        onequiz.quizAns2,
        onequiz.quizAns3,
        onequiz.quizAns4
      ];
      for (int i = 0; i < 4; i++) {
        int random = rd.nextInt(temp.length);
        answer[i] += temp[random];
        temp.removeAt(random);
      }
      setState(() {
        score = scores[number - 1];
        colors = List.filled(4, Colors.black);
        onequiz;
      });
      this.widget.quiz.removeAt(location);
    }
    Gogame();
  }

  void EndGame() {
    DateTime time = DateTime.now();
    //KetQua kp = new KetQua(
    //NguoiChoi: player!.MaNC, Diem: score, ThoiGian: time.toString());
    //KetQuaDAO.insertKQ(kp);
    //Navigator.pushNamed(context, "/Over", arguments: score);
  }

  // ignore: non_constant_identifier_names
  void ChooseAns(int index) {
    if (answer[index] != "") {
      checkChose = true;
      setState(() {
        colors[index] = Colors.yellow.shade800;
      });

      var time = 1;
      timer2 = Timer.periodic(Duration(seconds: 1), (timer) {
        if (time > 0) {
          time--;
        } else {
          timer2?.cancel();
          if (answer[index].contains(onequiz.answer)) {
            var time2 = 1;
            setState(() {
              colors[index] = Colors.green.shade800;
              number++;
            });
            timer2 = Timer.periodic(Duration(seconds: 1), (timer) {
              if (time2 > 0) {
                time2--;
              } else {
                timer2!.cancel();
              }
            });
          } else {
            for (int i = 0; i < 4; i++) {
              if (answer[i].contains(onequiz.answer)) {
                var time2 = 1;
                setState(() {
                  colors[index] = Colors.red.shade800;
                  colors[i] = Colors.green.shade800;
                });
                timer2 = Timer.periodic(Duration(seconds: 1), (timer) {
                  if (time2 > 0) {
                    time2--;
                  } else {
                    timer2!.cancel();
                    EndGame();
                  }
                });
              }
            }
          }
        }
      });
    }
  }

  void half() {
    if (imgName[0] == "5050.png") {
      int count = 0;
      for (int i = 0;; i++) {
        if (count < 2) {
          Random rd = new Random();
          int a = rd.nextInt(answer.length);
          if (!answer[a].contains(onequiz.answer) && answer[a] != "") {
            answer[a] = "";
            count++;
          }
        } else {
          setState(() {
            imgName[0] = "50_50used.png";
          });
          break;
        }
      }
    }
  }

  void callMyFriend() {
    if (imgName[1] == "call.png") {
      setState(() {
        imgName[1] = "call_used.png";
      });
      String feedback = "";
      for (int i = 0; i < 4; i++) {
        if (answer[i].contains(onequiz.answer)) {
          feedback = answer[i];
          break;
        }
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Gọi điện"),
            content: Text("Tôi nghĩ đáp án: $feedback"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void helpMe() async {
    if (imgName[2] == "helpme.png") {
      setState(() {
        imgName[2] = "donthelp.png";
      });

      int ptr = 100;
      var pt = List.filled(4, 0.0);
      for (int i = 0; i < 4; i++) {
        if (answer[i].contains(onequiz.answer)) {
          int a = (40 + rd.nextInt(60));

          height[i] = a.toDouble();
          ptr -= a;
        }
      }
      int count = 0;
      for (int i = 0; i < 4; i++) {
        if (!answer[i].contains(onequiz.answer)) {
          if (count < 2) {
            int a = rd.nextInt(ptr);

            height[i] = a.toDouble();
            ptr -= a;
            count++;
          } else {
            height[i] = ptr.toDouble();
          }
        }
      }
      used = true;
      setState(() {
        height;
      });
    }
  }

  void skipQuestion() async {
    if (imgName[3] == "skip.png") {
      setState(() {
        imgName[3] = "skip_used.png";
      });

      skip = true;
      setState(() {
        height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        automaticallyImplyLeading: false,
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
                  height: 76,
                ),
                CustomTimer(countdown: count),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Câu hỏi',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 50,
                          height: 50,
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
                      ],
                    ),
                    // Neon(
                    //   text: 'Điểm : 0',
                    //   color: Colors.red,
                    //   fontSize: 25,
                    //   font: NeonFont.NightClub70s,
                    //   flickeringText: true,
                    //   flickeringLetters: null,
                    //   glowingDuration: new Duration(seconds: 1),
                    // ),
                    Flexible(
                        child: Container(
                            child: Text("$score đ\n$number/10",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                                textAlign: TextAlign.center),
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.yellow.shade800,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: Colors.white)),
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            margin: EdgeInsets.only(top: 5, bottom: 5))),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.yellowAccent,
                  )),
                  width: 375,
                  height: 120,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(onequiz.question,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text('Chọn đáp án đúng trong các câu trả lời sau:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ChooseAns(0);
                  },
                  child: buildButton(context, 'A. ${onequiz.quizAns1}'),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    ChooseAns(1);
                  },
                  child: buildButton(context, 'B. ${onequiz.quizAns2}'),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    ChooseAns(2);
                  },
                  child: buildButton(context, 'C. ${onequiz.quizAns3}'),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    ChooseAns(3);
                  },
                  child: buildButton(context, 'D. ${onequiz.quizAns4}'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: const Icon(FontAwesomeIcons.phone,
                    //         color: Colors.white)),
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: const Icon(
                    //       Icons.bar_chart,
                    //       color: Colors.white,
                    //     )),
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: const Icon(
                    //       Icons.refresh_outlined,
                    //       color: Colors.white,
                    //     )),
                    // TextButton(
                    //     onPressed: () {},
                    //     child: Text(
                    //       '50:50',
                    //       style: TextStyle(color: Colors.white),
                    //     )),
                    // Flexible(
                    //     child: Row(children: [
                    Container(
                        child: ElevatedButton(
                            onPressed: () => half(),
                            child: Image.asset("images/helper/${imgName[0]}"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: Colors.white)),
                            )),
                        height: 40,
                        width: 70,
                        margin: EdgeInsets.fromLTRB(10, 5, 5, 5)),
                    Container(
                        child: ElevatedButton(
                            onPressed: () => callMyFriend(),
                            child: Image.asset("images/helper/${imgName[1]}"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: Colors.white)),
                            )),
                        height: 40,
                        width: 70,
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 5)),
                    Container(
                        child: ElevatedButton(
                            onPressed: () => helpMe(),
                            child: Image.asset("images/helper/${imgName[2]}"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: Colors.white)),
                            )),
                        height: 40,
                        width: 70,
                        margin: EdgeInsets.fromLTRB(10, 5, 5, 5)),
                    Container(
                        child: ElevatedButton(
                            onPressed: () => skipQuestion(),
                            child: Image.asset("images/helper/${imgName[3]}"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: Colors.white)),
                            )),
                        height: 40,
                        width: 70,
                        margin: EdgeInsets.fromLTRB(10, 5, 5, 5)),
                    // Container(
                    //   child: Text("Time:$count",
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(color: Colors.white, fontSize: 16)),
                    // ),
                    // ])),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
