import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/models/dream.dart';
import 'package:dream/models/favorite.dart';
import 'package:dream/models/firebase_response.dart';
import 'package:dream/models/users.dart';

import 'fb_auth_controller.dart';

class FbFavoriteController {
  final FirebaseFirestore _favorite = FirebaseFirestore.instance;

  Future<FirebaseResponse> create(
      {required String idDocDream, required Favorite favorite}) async {
    return await _favorite
        .collection('Favorite')
        .doc(idDocDream)
        .set(favorite.toMap())
        .then((value) async {
      return _generateResponse(status: true);
    }).catchError((error) => _generateResponse(status: false));
  }

  Future<FirebaseResponse> updateFavorite(
      {required bool isFavorite,
      required String IdDocDream,
      required int counter}) async {
    return await _favorite
        .collection('Favorite')
        .doc(IdDocDream)
        .update({'is_favorite': isFavorite, 'counter': counter})
        .then((value) => _generateResponse(status: true))
        .catchError((error) => _generateResponse(status: false));
  }

  Stream<QuerySnapshot<Favorite>> readFavorite(String id) async* {
    yield* _favorite
        .collection('Favorite')
        .where('dream_id', isEqualTo: id)
        .withConverter<Favorite>(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                    Favorite.fromMap(snapshot.data()!),
            toFirestore: (Favorite favorite, option) => favorite.toMap())
        .snapshots();
  }

  Stream<QuerySnapshot<Favorite>> readMyFavorite() async* {
    yield* _favorite
        .collection('Favorite')
        .where('user_id', isEqualTo: FbAuthController().currentUser.uid)
        .withConverter<Favorite>(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                    Favorite.fromMap(snapshot.data()!),
            toFirestore: (Favorite favorite, option) => favorite.toMap())
        .snapshots();
  }

  Stream<QuerySnapshot<Dream>> readDream({required List<String?> id}) async* {
    yield* _favorite
        .collection('Dream')
        .where('id_doc', whereIn: id)
        .withConverter<Dream>(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                    Dream.fromMap(snapshot.data()!),
            toFirestore: (Dream dream, option) => dream.toMap())
        .snapshots();
  }

  FirebaseResponse _generateResponse({required bool status}) {
    return FirebaseResponse(
        massage:
            status ? 'تم تنفيذ العملية بنجاح' : 'لم يتم تنفيذ العملية بنجاح',
        success: status);
  }

  Future<FirebaseResponse> delete({required String path}) async {
    return await _favorite
        .collection('Favorite')
        .doc(path)
        .delete()
        .then((value) => _generateResponse(status: true))
        .catchError((error) => _generateResponse(status: false));
  }
}
