import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neon/neon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:who_wants_to_be_a_millionaire/Object/rank_obj.dart';

import '../Provider/firestore_provider.dart';

class HistoryPage extends StatefulWidget {
  int credit;
  HistoryPage({required this.credit});

  @override
  State<HistoryPage> createState() {
    return HistoryPageState();
  }
}

class HistoryPageState extends State<HistoryPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<UserRankObject> lstUser = [];

  Future<void> getRank() async {
    final data = await FireStoreProvider.getUserRank();
    lstUser = data;
    setState(() {});
  }

  @override
  void initState() {
    getRank();
    super.initState();
  }

  void click() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 25,
        automaticallyImplyLeading: true,
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
                '${this.widget.credit}',
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
              children: [
                const SizedBox(
                  height: 150,
                ),
                Neon(
                  text: 'Xếp Hạng',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 350,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 35,
                            alignment: Alignment.centerLeft,
                            child: Text('Hạng'),
                          ),
                          Container(
                            width: 50,
                            alignment: Alignment.centerLeft,
                            child: Text('Avt'),
                          ),
                          Container(
                            width: 70,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Tên NV',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            width: 60,
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Ngày giờ',
                            ),
                          ),
                          Container(
                            width: 60,
                            alignment: Alignment.center,
                            child: Text(
                              'Điểm',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 350,
                      height: 300,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      child: ListView.builder(
                          itemCount: lstUser.length,
                          itemBuilder: (context, index) => Card(
                                child: Container(
                                  width: 350,
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 25,
                                        alignment: Alignment.centerLeft,
                                        child: CircleAvatar(
                                          maxRadius: 15,
                                          child: Text((index + 1).toString()),
                                        ),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 55,
                                        alignment: Alignment.centerLeft,
                                        child: CircleAvatar(
                                          maxRadius: 15,
                                          child: CircleAvatar(
                                            backgroundImage:
                                                AssetImage('images/avt1.jpg'),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        alignment: Alignment.centerLeft,
                                        child: Text(lstUser[index].fullName,
                                            style:
                                                TextStyle(color: Colors.blue)),
                                      ),
                                      Container(
                                        width: 80,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            '${lstUser[index].atTime.substring(0, 10)} \n ${lstUser[index].atTime.substring(11, 19)}',
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.green)),
                                      ),
                                      Container(
                                        width: 50,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '${lstUser[index].score}',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
