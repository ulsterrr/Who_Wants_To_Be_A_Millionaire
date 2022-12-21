import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neon/neon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:who_wants_to_be_a_millionaire/Object/category_obj.dart';
import 'package:who_wants_to_be_a_millionaire/Object/quiz_obj.dart';
import 'package:who_wants_to_be_a_millionaire/Provider/firestore_provider.dart';
import 'package:who_wants_to_be_a_millionaire/Screen/timebar_for_question.dart';

import 'EndGame_page.dart';
import 'Widget/button.dart';
import 'dart:async';
import 'dart:math';

class GamePage extends StatefulWidget {
  List<QuizObject> quiz;
  int credit;
  GamePage({Key? key, required this.quiz, required this.credit}) : super(key: key);

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
  List<String> colors = List.filled(4, 'df');
  //icon quyền trợ giúp
  List<String> imgName = ["5050.png", "call.png", "helpme.png", "skip.png"];
  //declare data
  final FirebaseAuth _auth = FirebaseAuth.instance;
  QuizObject onequiz = new QuizObject();

  //giới hạn 10 câu hỏi
  List<QuizObject> subList = [];

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
    int startIndex = 0;
    int endIndex = 10;
    subList = this.widget.quiz.sublist(startIndex, endIndex);
    int have = this.widget.quiz.length - subList.length;
    for (var i = 0; i < have; i++) {
      this.widget.quiz.removeAt(i);
    }
    Next();
  }

  //ghi đè phương thức back handler của button back điện thoại
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Bạn có chắc chắn?'),
            content: new Text(
                'Thoát game hiện tại và quay về màn hình chọn Lĩnh Vực'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: new Text('Tiếp tục',
                    style: TextStyle(color: Colors.green.shade400)),
              ),
              TextButton(
                onPressed: () {
                  count = 0;
                  Navigator.of(context).pop(true);
                }, // <-- SEE HERE
                child: new Text('Chấp nhận',
                    style: TextStyle(color: Colors.red.shade400)),
              ),
            ],
          ),
        )) ??
        false;
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
    answer = List.filled(4, "");
    Random rdonequiz = new Random();
    int location = 0;
    if (subList.length > 0) {
      int location = rdonequiz.nextInt(subList.length);
      onequiz = subList[location];
      var temp = [
        onequiz.quizAns1,
        onequiz.quizAns2,
        onequiz.quizAns3,
        onequiz.quizAns4
      ];
      answer[0] = "A: ";
      answer[1] = "B: ";
      answer[2] = "C: ";
      answer[3] = "D: ";
      for (int i = 0; i < 4; i++) {
        int random = rd.nextInt(temp.length);
        answer[i] += temp[random];
        temp.removeAt(random);
      }
      setState(() {
        score = scores[number - 1];
        colors = List.filled(4, 'df');
        onequiz;
      });
      subList.removeAt(location);
    }
    Gogame();
  }

  void EndGame() {
    DateTime time = DateTime.now();
    FireStoreProvider.gameToRank(scores[number - 1], time).then((value) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Thông báo"),
            content: Container(
              alignment: Alignment.center,
              height: 30,
              width: 100,
              child: Column(
                children: [
                  Text("Game đã kết thúc", style: TextStyle(fontSize: 30, color: Colors.red),),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "end", arguments: scores[number - 1]);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      ));
  }

  // ignore: non_constant_identifier_names
  void ChooseAns(int index) {
    if (answer[index] != "" && checkChose == false) {
      checkChose = true;
      setState(() {
        colors[index] = 'choose';
      });
      timer!.cancel();

      var time = 1;
      timer2 = Timer.periodic(Duration(seconds: 1), (timer) {
        if (time > 0) {
          time--;
        } else {
          timer2?.cancel();
          if (answer[index].contains(onequiz.answer)) {
            var time2 = 1;
            setState(() {
              colors[index] = 'true';
              number++;
            });
            timer2 = Timer.periodic(Duration(seconds: 1), (timer) {
              if (time2 > 0) {
                time2--;
              } else {
                timer2!.cancel();
                // ghi log người chơi chọn câu hỏi
                FireStoreProvider.updateUserQuiz(onequiz, true, count);
                Next();
              }
            });
          } else {
            for (int i = 0; i < 4; i++) {
              if (answer[i].contains(onequiz.answer)) {
                var time2 = 1;
                setState(() {
                  colors[index] = 'false';
                  colors[i] = 'true';
                });
                timer2 = Timer.periodic(Duration(seconds: 1), (timer) {
                  if (time2 > 0) {
                    time2--;
                  } else {
                    timer2!.cancel();
                    // ghi log người chơi chọn câu hỏi
                    FireStoreProvider.updateUserQuiz(onequiz, false, count);
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
          int a = rd.nextInt(4);
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
            title: Text("Gọi điện cho Google"),
            content: Container(
              height: 200,
              width: 250,
              child: Column(
                children: [
                  Text("Tôi nghĩ đáp án: $feedback\nBạn cứ tin tôi ^^"),
                  Image.asset(
                    'images/helper/hehe.gif',
                    //width: 200, height: 100,
                  ),
                ],
              ),
            ),
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

      var answers = List.filled(4, 0.0);

      int ptr = 100;
      var pt = List.filled(4, 0.0);
      for (int i = 0; i < 4; i++) {
        if (answer[i].contains(onequiz.answer)) {
          int a = (40 + rd.nextInt(60));

          pt[i] = a.toDouble();
          ptr -= a;
        }
      }
      int count = 0;
      for (int i = 0; i < 4; i++) {
        if (!answer[i].contains(onequiz.answer)) {
          if (count < 2) {
            int a = rd.nextInt(ptr);

            pt[i] = a.toDouble();
            ptr -= a;
            count++;
          } else {
            pt[i] = ptr.toDouble();
          }
        }
      }
      used = true;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Khán giả phản hồi"),
            content: Container(
              width: 300,
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    verticalDirection: VerticalDirection.up,
                    children: [
                      Text('A.'),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        width: 25,
                        height: pt[0],
                        color: Colors.blue,
                      ),
                      Text('${pt[0]}%'),
                    ],
                  ),
                  Column(
                    verticalDirection: VerticalDirection.up,
                    children: [
                      Text('B.'),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        width: 25,
                        height: pt[1],
                        color: Colors.blue,
                      ),
                      Text('${pt[1]}%')
                    ],
                  ),
                  Column(
                    verticalDirection: VerticalDirection.up,
                    children: [
                      Text('C.'),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        width: 25,
                        height: pt[2],
                        color: Colors.blue,
                      ),
                      Text('${pt[2]}%'),
                    ],
                  ),
                  Column(
                    verticalDirection: VerticalDirection.up,
                    children: [
                      Text('D.'),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        width: 25,
                        height: pt[3],
                        color: Colors.blue,
                      ),
                      Text('${pt[3]}%'),
                    ],
                  ),
                ],
              ),
            ),
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

  void skipQuestion() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Bạn có chắn chắn?"),
          content: const Text(
              "Quyền trợ giúp bỏ qua câu hỏi chỉ có thể sử dụng 1 lần!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (imgName[3] == "skip.png") {
                  setState(() {
                    imgName[3] = "skip_used.png";
                  });

                  Random rd = new Random();
                  int pick = rd.nextInt(this.widget.quiz.length);
                  subList.add(this.widget.quiz[pick]);
                  this.widget.quiz.removeAt(pick);
                  subList.removeAt(number);
                  Next();

                  skip = true;
                  setState(() {
                    height;
                  });
                }
                Navigator.of(context).pop(false);
              }, //<-- SEE HERE
              child: new Text('Chấp nhận', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              }, // <-- SEE HERE
              child:
                  new Text('Không dùng', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //đặt Scaffold trong WillPopScope để handle button back điện thoại
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                  TimerLoading(context, count),
                  const SizedBox(
                    height: 5,
                  ),
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
                            width: 70,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Text(
                              '${number}/10',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
                      Row(
                        children: [
                          // Text(
                          //   'Tiền thưởng',
                          //   style: TextStyle(color: Colors.white, fontSize: 20),
                          // ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          Container(
                              child: Text("Tiền thưởng\n${score} VNĐ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  textAlign: TextAlign.center),
                              alignment: Alignment.center,
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.yellow.shade800,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(color: Colors.white)),
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              margin: EdgeInsets.only(top: 5, bottom: 5)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, bottom: 15, top: 15),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Chọn đáp án đúng trong các câu trả lời sau:',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ChooseAns(0);
                    },
                    child: buttonQuiz(context, '${answer[0]}', colors[0]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      ChooseAns(1);
                    },
                    child: buttonQuiz(context, '${answer[1]}', colors[1]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      ChooseAns(2);
                    },
                    child: buttonQuiz(context, '${answer[2]}', colors[2]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      ChooseAns(3);
                    },
                    child: buttonQuiz(context, '${answer[3]}', colors[3]),
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
      ),
    );
  }
}
