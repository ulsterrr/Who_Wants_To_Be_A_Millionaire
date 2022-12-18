class QuizbyUserObject {
  late final int id;
  final int userId;
  final int quizId;
  final String quizChoice;
  final int countFailed;
  final int countSuccess;
  final String atTime;

  QuizbyUserObject(
      {this.id = 0,
      this.userId = 0,
      this.quizId = 0,
      this.quizChoice = '',
      this.countFailed = 0,
      this.countSuccess = 0,
      this.atTime = ''});

  QuizbyUserObject.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        userId = r['userId'],
        quizId = r['quizId'],
        quizChoice = r['quizChoice'],
        countFailed = r['countFailed'],
        countSuccess = r['countSuccess'],
        atTime = r['atTime'];
}
