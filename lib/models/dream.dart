class Dream {
  late String createdUid;
  String? idDoc;
  late String title;
  late String description;
  String? replyMessage;
  late String maritalstatus;
  late bool isFavorite;
  late String age;
  late String gender;
  late String functionalStatus;
  late int counter;
  int createdDate = DateTime.now().millisecondsSinceEpoch;
  late String token;
  late bool wasCommented =false;

  Dream({
  required  this.title,
  required  this.description,
  required  this.replyMessage,
  required  this.isFavorite,
  required  this.maritalstatus,
  required  this.age,
  required  this.gender,
  required  this.functionalStatus,
  required  this.counter,
  required  this.token,
  });

  Dream.fromMap(Map<String, dynamic> map) {
    createdUid = map['created_uid'];
    title = map['title'];
    isFavorite = map['is_favorite'];
    counter = map['counter'];
    description = map['description'];
    replyMessage = map['replyMessage'];
    maritalstatus = map['maritalstatus'];
    age = map['age'];
    idDoc = map['id_doc'];
    gender = map['gender'];
    functionalStatus = map['functionalStatus'];
    createdDate = map['created_date'];
    token = map['token'];
    wasCommented = map['wasCommented'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['created_uid'] = createdUid;
    map['title'] = title;
    map['is_favorite'] = isFavorite;
    map['description'] = description;
    map['replyMessage'] = replyMessage;
    map['maritalstatus'] = maritalstatus;
    map['age'] = age;
    map['id_doc'] = idDoc;
    map['gender'] = gender;
    map['functionalStatus'] = functionalStatus;
    map['created_date'] = createdDate;
    map['token'] = token;
    map['counter'] = counter;
    map['wasCommented'] = wasCommented;
    return map;
  }
}
