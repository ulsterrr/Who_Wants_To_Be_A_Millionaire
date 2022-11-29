class CreditsObject {
  final int id;
  final int creditsId;
  final String creditsType;

  CreditsObject(this.id, this.creditsId, this.creditsType);

  CreditsObject.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        creditsId = r['creditsId'],
        creditsType = r['creditsType'];
}
