import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/models/commenter.dart';
import 'package:dream/models/firebase_response.dart';
import 'package:flutter/material.dart';

class FbCommenterFireStoreController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<FirebaseResponse> create({required Commenter commenter}) async {
    return await _fireStore
        .collection('Commenter')
        .add(commenter.toMap())
        .then((value) async {
      await value.update({'id_doc': value.id});
      return _generateResponse(status: true);
    }).catchError((error) => _generateResponse(status: false));
  }

  FirebaseResponse _generateResponse({required bool status}) {
    return FirebaseResponse(
        massage:
            status ? 'تم تنفيذ العملية بنجاح' : 'لم يتم تنفيذ العملية بنجاح',
        success: status);
  }

  Future<QuerySnapshot<Commenter>?> readCommenterData(
      {required String email, required String password}) async {
    try {
      return _fireStore
          .collection('Commenter')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .withConverter<Commenter>(
              fromFirestore:
                  (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                      Commenter.fromMap(snapshot.data()!),
              toFirestore: (Commenter commenter, option) => commenter.toMap())
          .snapshots()
          .first
          .catchError((error) => _generateResponse(status: false));
    } catch (status) {
      FirebaseResponse _generateResponse({required bool status}) {
        return FirebaseResponse(
            massage: status
                ? 'تم تنفيذ العملية بنجاح'
                : 'لم يتم تنفيذ العملية بنجاح',
            success: status);
      }
    }
  }

  Stream<QuerySnapshot<Commenter>> read() async* {
    yield* _fireStore
        .collection('Commenter')
        .withConverter<Commenter>(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                    Commenter.fromMap(snapshot.data()!),
            toFirestore: (Commenter commenter, option) => commenter.toMap())
        .snapshots();
  }

  Stream<QuerySnapshot<Commenter>> readCommenterDetails(
      {required String id}) async* {
    yield* _fireStore
        .collection('Commenter')
        .where('id_doc', isEqualTo: id)
        .withConverter<Commenter>(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                    Commenter.fromMap(snapshot.data()!),
            toFirestore: (Commenter commenter, option) => commenter.toMap())
        .snapshots();
  }

  Future<FirebaseResponse> updateCounter(
      {required String IdDocDream, required int counterCommenter}) async {
    return await _fireStore
        .collection('Commenter')
        .doc(IdDocDream)
        .update({'counter': counterCommenter + 1})
        .then((value) => _generateResponse(status: true))
        .catchError((error) => _generateResponse(status: false));
  }

  Future<FirebaseResponse> updateCounterDown({
    required String IdDocCommenter,
    required int counterCommenter,
  }) async {
    return await _fireStore
        .collection('Commenter')
        .doc(IdDocCommenter)
        .update({'counter': 0}).then(
      (value) => _generateResponse(status: true),
    );
  }

  Future<FirebaseResponse> delete({required String path}) async {
    return await _fireStore
        .collection('Commenter')
        .doc(path)
        .delete()
        .then((value) => _generateResponse(status: true))
        .catchError((error) => _generateResponse(status: false));
  }

}
// Future<bool> isDuplicateUniqueName(String uniqueName) async {
//   QuerySnapshot query = await FirebaseFirestore.instance
//       .collection('PATH_TO_USERS_COLLECTION')
//       .where('uniqueName', isEqualTo: uniqueName)
//       .get();
//   return query.docs.isNotEmpty;
// }
