class UserCreditObject {
  final int id;
  final int userId;
  final String fullName;
  final int score;
  final String atTime;

  UserCreditObject(
      this.id, this.userId, this.fullName, this.score, this.atTime);

  UserCreditObject.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        userId = r['userId'],
        fullName = r['fullName'],
        score = r['score'],
        atTime = r['atTime'];
}
