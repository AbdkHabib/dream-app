//commenter account to admin screen
class Commenter {
  String? idDoc;
  late String userName;
  late String phoneNumber;
  late String email;
  late String password;
  late int counter;
  int createdDate = DateTime.now().millisecondsSinceEpoch;
  Commenter({
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.counter,
  });

  Commenter.fromMap(Map<String, dynamic> map) {
    userName = map['user_name'];
    phoneNumber = map['phone_number'];
    email = map['email'];
    idDoc = map['id_doc'];
    password = map['password'];
    counter = map['counter'];
      createdDate = map['createdDate'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['user_name'] = userName;
    map['phone_number'] = phoneNumber;
    map['email'] = email;
    map['id_doc'] = idDoc;
    map['password'] = password;
    map['counter'] = counter;
    map['createdDate'] = createdDate;

    return map;
  }
}
