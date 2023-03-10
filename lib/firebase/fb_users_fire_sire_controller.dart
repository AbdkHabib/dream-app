import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/models/firebase_response.dart';
import 'package:dream/models/users.dart';

import 'fb_auth_controller.dart';

class FbUsersFireStoreController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<FirebaseResponse> create({required Users users}) async {
    return await _fireStore
        .collection('Users')
        .add(users.toMap())
        .then((value) async {
      await value.update({'id_doc': value.id});
      return _generateResponse(status: true);
    }).catchError((error) => _generateResponse(status: false));
  }
  Stream<QuerySnapshot<Users>> read() async* {
    yield* _fireStore
        .collection('Users')
        .withConverter<Users>(
        fromFirestore:
            (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                Users.fromMap(snapshot.data()!),
        toFirestore: (Users users, option) => users.toMap())
        .snapshots();
  }
  FirebaseResponse _generateResponse({required bool status}) {
    return FirebaseResponse(
        massage:
            status ? 'تم تنفيذ العملية بنجاح' : 'لم يتم تنفيذ العملية بنجاح',
        success: status);
  }
}
