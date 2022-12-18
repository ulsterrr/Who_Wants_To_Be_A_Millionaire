class UserObject {
  final int id;
  final String username;
  final String fullName;
  final String passWord;
  final String email;
  final int? totalPoint;
  final int? totalCredit;

  UserObject(
      {required this.id,
      required this.username,
      required this.fullName,
      required this.passWord,
      required this.email,
      this.totalPoint, this.totalCredit});

  UserObject.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        username = r['username'],
        fullName = r['fullName'],
        passWord = r['passWord'],
        email = r['email'],
        totalPoint = r['totalPoint'],
        totalCredit = r['totalCredit'];
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'username': username,
      'fullName': fullName,
      'passWord': passWord,
      'email': email,
      'totalPoint': totalPoint,
      'totalCredit': totalCredit
    };
  }
}
