import 'dart:ffi';

class QuizbyUserObject {
  final int id;
  final int quizId;
  final int userId;
  final String quizChoice;
  final int countFailed;
  final int countSuccess;
  final Float atTime;
  QuizbyUserObject(this.id, this.quizId, this.userId, this.quizChoice, this.countFailed, this.countSuccess, this.atTime);

  QuizbyUserObject.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        quizId = r['quizId'],
        userId = r['userId'],
        quizChoice = r['quizChoice'],
        countFailed = r['countFailed'],
        countSuccess = r['countSuccess'],
        atTime = r['atTime'];

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'quizId': quizId,
      'userId': userId,
      'quizChoice': quizChoice,
      'countFailed': countFailed,
      'countSuccess': countSuccess,
      'atTime': atTime
    };
  }
}
