//commenter account to admin screen
class Favorite {
  String? dreamId;
  late String Uid;


  Favorite({
    required this.dreamId,

    required this.Uid,

  });

  Favorite.fromMap(Map<String, dynamic> map) {
    dreamId = map['dream_id'];
    Uid = map['user_id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['dream_id'] = dreamId;
    map['user_id'] = Uid;

    return map;
  }
}
