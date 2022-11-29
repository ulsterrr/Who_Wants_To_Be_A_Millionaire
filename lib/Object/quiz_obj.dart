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
  final DateTime? manyTime;

  QuizObject(
      {required this.id,
      required this.catetoryId,
      required this.question,
      required this.quizAns1,
      required this.quizAns2,
      required this.quizAns3,
      required this.quizAns4,
      required this.answer,
      this.level,
      this.manyTime,
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
}
