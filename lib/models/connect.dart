//commenter account to admin screen
class Connect {
  String? idDoc;
  late String title;
  late String description;
  int createdDate = DateTime.now().millisecondsSinceEpoch;

  Connect({
    required this.title,
    required this.description,
  });

  Connect.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    description = map['description'];
    idDoc = map['id_doc'];
    createdDate = map['created_date'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['id_doc'] = idDoc;
    map['created_date'] = createdDate;

    return map;
  }
}
