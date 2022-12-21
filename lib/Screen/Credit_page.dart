import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:neon/neon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:who_wants_to_be_a_millionaire/Provider/firestore_provider.dart';

class Credit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreditPage();
  }
}

class CreditPage extends State<Credit> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int credit = 0;
  Future<void> getCredit() async {
    credit = 0;
    await FireStoreProvider.getUserCredit().then((value) {
      credit = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getCredit();
  }

  void click(int id, int qty) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Bạn có chắc chắn mua?"),
            content: const Text("Giá rất mắc, bạn nên cân nhắc!"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  credit += qty;
                  setState(() {
                    
                  });
                  FireStoreProvider.buyCreditUser(id, qty)
                      .then((value) => Navigator.of(context).pop(false));
                }, //<-- SEE HERE
                child: new Text('Cắn răng mua',
                    style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                }, // <-- SEE HERE
                child:
                    new Text('Hết tiền', style: TextStyle(color: Colors.black)),
              ),
            ],
          );
        });
  }

  var diamond = [
    2000,
    5000,
    10000,
    20000,
  ];

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
                  '${credit}',
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
                height: 100,
              ),
              Neon(
                text: 'Mua Credit',
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
                  Container(
                    width: 325,
                    height: 380,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: GridView.builder(
                        itemCount: 4,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0),
                        itemBuilder: (BuildContext context, int index) {
                          // return Image.asset('images/avt1.jpg');
                          return GestureDetector(
                            onTap: () {
                              click(1, diamond[index]);
                              setState(() {});
                            },
                            child: Card(
                              color: Colors.orange,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text('${diamond[index]}',
                                        style: TextStyle(color: Colors.yellow)),
                                    Expanded(
                                        child: Icon(FontAwesomeIcons.gem,
                                            size: 50.0, color: Colors.yellow)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
