import 'package:cloud_firestore/cloud_firestore.dart';

class QuizObject {
  final int id;
  final int catetoryId;
  final String question;
  final String quizAns1;
  final String quizAns2;
  final String quizAns3;
  final String quizAns4;
  final String answer;
  final int? level;
  final int? point;
  final int manyTime;

  QuizObject(
      { this.id = 0,
      this.catetoryId = 0,
      this.question = '',
      this.quizAns1 = '',
      this.quizAns2 = '',
      this.quizAns3 = '',
      this.quizAns4 = '',
      this.answer = '',
      this.level,
      this.manyTime = 0,
      this.point});

  QuizObject.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        catetoryId = r['catetoryId'],
        question = r['question'],
        quizAns1 = r['quizAns1'],
        quizAns2 = r['quizAns2'],
        quizAns3 = r['quizAns3'],
        quizAns4 = r['quizAns4'],
        answer = r['answer'],
        level = r['level'],
        manyTime = r['manyTime'],
        point = r['point'];
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'catetoryId': catetoryId,
      'question': question,
      'quizAns1': quizAns1,
      'quizAns2': quizAns2,
      'quizAns3': quizAns3,
      'quizAns4': quizAns4,
      'answer': answer,
      'level': level,
      'manyTime': manyTime,
      'point': point
    };
  }

  factory QuizObject.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return QuizObject(
      id: data?['id'],
      catetoryId: data?['catetoryId'],
      question: data?['question'],
      quizAns1: data?['quizAns1'],
      quizAns2: data?['quizAns2'],
      quizAns3: data?['quizAns3'],
      quizAns4: data?['quizAns4'],
      answer: data?['answer'],
      level: data?['level'],
      manyTime: data?['manyTime'],
      point: data?['point'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "catetoryId": catetoryId,
      "question": question,
      "quizAns1": quizAns1,
      "quizAns2": quizAns2,
      "quizAns3": quizAns3,
      "quizAns4": quizAns4,
      "answer": answer,
      if (level != null) "level": level,
      if (manyTime != null) "manyTime": manyTime,
      if (point != null) "point": point,
    };
  }
}
