//commenter account to admin screen
class Users {
  String? idDoc;
  late String userName;
  late String email;
   String? password;

  int createdDate = DateTime.now().millisecondsSinceEpoch;
  Users({
    required this.userName,
    required this.email,

  });

  Users.fromMap(Map<String, dynamic> map) {
    userName = map['user_name'];
    email = map['email'];
    idDoc = map['id_doc'];


    createdDate = map['createdDate'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['user_name'] = userName;
    map['email'] = email;

    map['createdDate'] = createdDate;

    return map;
  }
}
