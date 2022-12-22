class UserCreditObject {
  final int id;
  final String userId;
  final int creditsId;
  final int quantity;
  final String buyTime;

  UserCreditObject(
      this.id, this.userId, this.creditsId, this.quantity, this.buyTime);

  UserCreditObject.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        userId = r['userId'],
        creditsId = r['creditsId'],
        quantity = r['quantity'],
        buyTime = r['buyTime'];
}
