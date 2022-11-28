class UserCreditObject {
  final int id;
  final int userId;
  final int creditsId;
  final int quantity;
  final DateTime buyTime;

  UserCreditObject(
      this.id, this.userId, this.creditsId, this.quantity, this.buyTime);

  UserCreditObject.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        userId = r['userId'],
        creditsId = r['creditsId'],
        quantity = r['quantity'],
        buyTime = r['buyTime'];
}
