class UserRankObject {
  final int id;
  final String userId;
  final String fullName;
  final int score;
  final String atTime;

  UserRankObject(this.id, this.userId, this.fullName, this.score, this.atTime);

  UserRankObject.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        userId = r['userId'],
        fullName = r['fullName'],
        score = r['score'],
        atTime = r['atTime'];
}
