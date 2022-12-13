import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:who_wants_to_be_a_millionaire/Object/quiz_obj.dart';

class CustomTimer extends StatefulWidget {
  QuizObject quizz;
  CustomTimer({Key? key, required this.leftSeconds, required this.quizz}) : super(key: key);

  final int leftSeconds;

  @override
  State<CustomTimer> createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 25,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white38,
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Consumer(
            builder: (context, ref, child) {
              return FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: this.widget.quizz.manyTime / 60,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xff37EBBC),
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: 10,
            child: Consumer(
              builder: (context, ref, child) {
                return Text('${this.widget.quizz.manyTime} seconds');
              },
            ),
          ),
          const Positioned(
            right: 10,
            child: Icon(
              Icons.timer,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}