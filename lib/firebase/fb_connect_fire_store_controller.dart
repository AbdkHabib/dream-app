import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/firebase/fb_auth_controller.dart';
import 'package:dream/models/connect.dart';
import 'package:dream/models/firebase_response.dart';

class FbConnectFireStoreController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<FirebaseResponse> create({required Connect connect}) async {
    return await _fireStore
        .collection('ContactUs')
        .add(connect.toMap())
        .then((value) async {
      await value.update({'id_doc': value.id});
      await value.update({'created_uid': FbAuthController().currentUser.uid});
      return _generateResponse(status: true);
    }).catchError((error) => _generateResponse(status: false));
  }

  FirebaseResponse _generateResponse({required bool status}) {
    return FirebaseResponse(
        massage: status
            ? 'تم تنفيذ العملية بنجاح'
            : ' لم يتم تنفيذ العملية بنجاح يجب تسجيل الدخول اولاً',
        success: status);
  }

  Stream<QuerySnapshot<Connect>> read() async* {
    yield* _fireStore
        .collection('ContactUs')
        .withConverter<Connect>(
            fromFirestore:
                (DocumentSnapshot<Map<String, dynamic>> snapshot, option) =>
                    Connect.fromMap(snapshot.data()!),
            toFirestore: (Connect connect, option) => connect.toMap())
        .snapshots();
  }
}
