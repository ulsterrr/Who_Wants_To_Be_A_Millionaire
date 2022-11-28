class CatebyUserObject {
  final int id;
  final int userId;
  final int catetoryId;
  final bool isPass;
  final int passCount;

  CatebyUserObject(this.id, this.userId, this.catetoryId, this.isPass, this.passCount);

  CatebyUserObject.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        userId = r['userId'],
        catetoryId = r['catetoryId'],
        isPass = r['isPass'],
        passCount = r['passCount'];
}
