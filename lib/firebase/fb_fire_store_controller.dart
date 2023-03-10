import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/firebase/fb_auth_controller.dart';
import 'package:dream/models/dream.dart';
import 'package:dream/models/firebase_response.dart';

class FbFireStoreController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<FirebaseResponse> create({required Dream dream}) async {
    return await _fireStore
        .collection('Dream')
        .add(dream.toMap())
        .then((value) async {
      await value.update({'created_uid': FbAuthController().currentUser.uid});
      await value.update({'id_doc': value.id});
      return _generateResponse(status: true);
    }).catchError((error) => _generateResponse(status: false));
  }

  Future<FirebaseResponse> update(
      {required String replyString, required String IdDocDream}) async {
    return await _fireStore
        .collection('Dream')
        .doc(IdDocDream)
        .update({'replyMessage': replyString})
        .then((value) => _generateResponse(status: true))
        .catchError((error) => _generateResponse(status: false));
  }

  Future<FirebaseResponse> updateFavorite(
      {required bool isFavorite, required String IdDocDream}) async {
    return await _fireStore
        .collection('Dream')
        .doc(IdDocDream)
        .update({'is_favorite': isFavorite})
        .then((value) => _generateResponse(status: true))
        .catchError((error) => _generateResponse(status: false));
  }

  Future<FirebaseResponse> updateFlagBtnCommenterDisable(
      {required String IdDocDream}) async {
    return await _fireStore
        .collection('Dream')
        .doc(IdDocDream)
        .update({'wasCommented': true})
        .then((value) => _generateResponse(status: true))
        .catchError((error) => _generateResponse(status: false));
  }

  Future<FirebaseResponse> updateFlagBtnCommenterEnable(
      {required String IdDocDream}) async {
    return await _fireStore
        .collection('Dream')
        .doc(IdDocDream)
        .update({'wasCommented': true})
        .then((value) => _generateResponse(status: true))
        .catchError((error) => _generateResponse(status: false));
  }
  Future<FirebaseResponse> updateFlagBtnCommenter(
      {required String IdDocDream}) async {
    return await _fireStore
        .collection('Dream')
        .doc(IdDocDream)
        .update({'wasCommented': false})
        .then((value) => _generateResponse(status: true))
        .catchError((error) => _generateResponse(status: false));
  }

  Stream<QuerySnapshot<Dream>> readAllDreamUser() async* {
    yield* _fireStore
        .collection('Dream')
        .where('replyMessage', isNotEqualTo: '')
        .withConverter<Dream>(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                    Dream.fromMap(snapshot.data()!),
            toFirestore: (Dream dream, option) => dream.toMap())
        .snapshots();
  }

  Stream<QuerySnapshot<Dream>> readAllDreamCommenter() async* {
    yield* _fireStore
        .collection('Dream')
        .where('replyMessage', isEqualTo: '')
        .withConverter<Dream>(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                    Dream.fromMap(snapshot.data()!),
            toFirestore: (Dream dream, option) => dream.toMap())
        .snapshots();
  }

  Future<FirebaseResponse> delete({required String path}) async {
    return await _fireStore
        .collection('Dream')
        .doc(path)
        .delete()
        .then((value) => _generateResponse(status: true))
        .catchError((error) => _generateResponse(status: false));
  }

  FirebaseResponse _generateResponse({required bool status}) {
    return FirebaseResponse(
        massage:
            status ? 'تم تنفيذ العملية بنجاح' : 'لم يتم تنفيذ العملية بنجاح',
        success: status);
  }

  //read all dream
  Stream<QuerySnapshot<Dream>> read() async* {
    yield* _fireStore
        .collection('Dream')
        .withConverter<Dream>(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                    Dream.fromMap(snapshot.data()!),
            toFirestore: (Dream dream, option) => dream.toMap())
        .snapshots();
  }

  Stream<QuerySnapshot<Dream>> readAllUserDream() async* {
    yield* _fireStore
        .collection('Dream')
        .where('created_uid', isEqualTo: FbAuthController().currentUser.uid)
        .withConverter<Dream>(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                    Dream.fromMap(snapshot.data()!),
            toFirestore: (Dream dream, option) => dream.toMap())
        .snapshots();
  }

  Stream<QuerySnapshot<Dream>> readWaitingDream() async* {
    yield* _fireStore
        .collection('Dream')
        .where('created_uid', isEqualTo: FbAuthController().currentUser.uid)
        .where('replyMessage', isEqualTo: '')
        .withConverter<Dream>(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                    Dream.fromMap(snapshot.data()!),
            toFirestore: (Dream dream, option) => dream.toMap())
        .snapshots();
  }

  Stream<QuerySnapshot<Dream>> readFinishedDream() async* {
    yield* _fireStore
        .collection('Dream')
        .where('created_uid', isEqualTo: FbAuthController().currentUser.uid)
        .where('replyMessage',isNotEqualTo: '')
        .withConverter<Dream>(
        fromFirestore:
            (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
            Dream.fromMap(snapshot.data()!),
        toFirestore: (Dream dream, option) => dream.toMap())
        .snapshots();
  }

  Stream<QuerySnapshot<Dream>> getAdminFcmToken({
    required Dream dream,
  }) async* {
    yield* _fireStore
        .collection('Dream')
        .where('token', isEqualTo: dream)
        .withConverter<Dream>(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                    Dream.fromMap(snapshot.data()!),
            toFirestore: (Dream dream, option) => dream.toMap())
        .snapshots();
  }

  Stream<QuerySnapshot<Dream>> readFavoriteDream() async* {
    yield* _fireStore
        .collection('Dream')
        .where('is_favorite', isNotEqualTo: true)
        .withConverter<Dream>(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                    Dream.fromMap(snapshot.data()!),
            toFirestore: (Dream dream, option) => dream.toMap())
        .snapshots();
  }

  Stream<QuerySnapshot<Dream>> getDreamFcmToken(String token) async* {
    yield* _fireStore
        .collection('Dream')
        .where('token', isEqualTo: token)
        .withConverter<Dream>(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                    Dream.fromMap(snapshot.data()!),
            toFirestore: (Dream dream, option) => dream.toMap())
        .snapshots();
  }

  Stream<QuerySnapshot<Dream>> readDreamDetails({required String id}) async* {
    yield* _fireStore
        .collection('Dream')
        .where('id_doc', isEqualTo: id)
        .withConverter<Dream>(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                    Dream.fromMap(snapshot.data()!),
            toFirestore: (Dream dream, option) => dream.toMap())
        .snapshots();
  }

  Future<FirebaseResponse> updateDreamCounter(
      {required String IdDocDream, required int counter}) async {
    return await _fireStore
        .collection('Dream')
        .doc(IdDocDream)
        .update({'counter': counter + 1})
        .then((value) => _generateResponse(status: true))
        .catchError((error) => _generateResponse(status: false));
  }
}
