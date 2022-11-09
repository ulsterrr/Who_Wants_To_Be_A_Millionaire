import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neon/neon.dart';

class LinhVucPage extends StatelessWidget {
  List<String> lsTitle = [
    'Khoa học - kỹ thuật',
    'Phim ảnh',
    'Văn hóa - xã hội',
    'Lịch sử - địa lí'
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
                'Username',
                style: TextStyle(color: Colors.white),
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
                  height: 100,
                ),
                Neon(
                  text: 'Điểm : 0',
                  color: Colors.red,
                  fontSize: 35,
                  font: NeonFont.TextMeOne,
                  flickeringText: true,
                  flickeringLetters: null,
                  glowingDuration: new Duration(seconds: 1),
                ),
                const SizedBox(
                  height: 10,
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
                    '5',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text('Chọn lĩnh vực',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    width: 250,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromARGB(255, 2, 1, 71),
                              Colors.cyan,
                              Color.fromARGB(255, 1, 25, 44),
                            ])),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        lsTitle[1],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    width: 250,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromARGB(255, 2, 1, 71),
                              Colors.cyan,
                              Color.fromARGB(255, 1, 25, 44),
                            ])),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        lsTitle[2],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    width: 250,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromARGB(255, 2, 1, 71),
                              Colors.cyan,
                              Color.fromARGB(255, 1, 25, 44),
                            ])),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        lsTitle[3],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    width: 250,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromARGB(255, 2, 1, 71),
                              Colors.cyan,
                              Color.fromARGB(255, 1, 25, 44),
                            ])),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        lsTitle[0],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            )),
      ),
    );
  }
}
