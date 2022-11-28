class FavoriesObject {
  final int id;
  final int quizId;
  final String userId;

  FavoriesObject(this.id, this.quizId, this.userId);

  FavoriesObject.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        quizId = r['quizId'],
        userId = r['userId'];
}
