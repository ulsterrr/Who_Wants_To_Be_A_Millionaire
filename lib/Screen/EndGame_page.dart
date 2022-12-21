import 'package:flutter/material.dart';
import 'package:who_wants_to_be_a_millionaire/Screen/Home_page.dart';

class EndGame extends StatelessWidget {
  int? score;
  EndGame({this.score});
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 63, 77, 234),
      body: Container(
          constraints: BoxConstraints.expand(),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Bạn được $score VNĐ\nXin chúc mừng",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, color: Colors.white)),
              Image.asset("images/helper/congrats.gif"),
              Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    child: Text("Quay về",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          side: BorderSide(color: Colors.white)),
                    ),
                  ),
                  height: 40,
                  width: 180,
                  margin: EdgeInsets.all(20))
            ],
          ))),
    );
  }
}
