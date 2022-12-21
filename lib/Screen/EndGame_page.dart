import 'package:flutter/material.dart';

class EndGame extends StatelessWidget {
  int? score;
  EndGame({this.score});
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: Container(
          constraints: BoxConstraints.expand(),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Bạn được $score đ\nXin chúc mừng",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, color: Colors.white)),
              Image.asset("images/helper/congrats.gif"),
              Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text("Quay về",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
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
