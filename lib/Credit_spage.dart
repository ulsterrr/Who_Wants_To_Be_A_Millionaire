import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neon/neon.dart';

class CreditSpage extends StatelessWidget {
  void click() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(''), backgroundColor: Colors.cyan),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Username',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '2.000',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.yellowAccent),
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
                const SizedBox(
                  height: 50,
                ),
                Neon(
                  text: 'Mua Credit',
                  color: Colors.red,
                  fontSize: 35,
                  font: NeonFont.TextMeOne,
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
                      height: 10,
                      width: 400,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 325,
                      height: 380,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(11.0),
                        child: GridView.builder(
                          itemCount: 4,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0),
                          itemBuilder: (BuildContext context, int index) {
                            // return Image.asset('images/avt1.jpg');
                            return Card(
                                color: Colors.orange,
                                child: Center(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text('5.000',
                                            style: TextStyle(
                                                color: Colors.yellow)),
                                        Expanded(
                                            child: Icon(FontAwesomeIcons.gem,
                                                size: 50.0,
                                                color: Colors.yellow)),
                                      ]),
                                ));
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.dollarSign),
                                Text('450')
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
