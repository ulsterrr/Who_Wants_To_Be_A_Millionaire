class CategoryObject {
  final int id;
  final String categoryName;
  final String? note;
  CategoryObject({required this.id, required this.categoryName, this.note});

  CategoryObject.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        categoryName = r['categoryName'],
        note = r['note'];

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'categoryName': categoryName,
      'note': note
    };
  }
}
