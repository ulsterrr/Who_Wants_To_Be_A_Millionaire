import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neon/neon.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void click() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 170,
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
              width: 20,
            ),
            Container(
              child: Text(
                '2.000',
                style: TextStyle(color: Colors.yellowAccent),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.gem,
                color: Colors.yellowAccent,
              ),
            )
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 50,
                      width: 400,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) => Card(
                                child: Container(
                                  width: 300,
                                  height: 50,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        child: Text((index + 1).toString()),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage('images/avt1.jpg'),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text('Họ tên'),
                                      const SizedBox(
                                        height: 10,
                                      )
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
