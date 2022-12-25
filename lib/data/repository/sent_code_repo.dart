import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SentCodeRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  BehaviorSubject errorMessage = BehaviorSubject.seeded('');
  BehaviorSubject userData = BehaviorSubject.seeded({});

  Future<void> sentCode(String verificationId, String controllerText) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: controllerText,
    );
    try {
      await _auth.signInWithCredential(credential).then((UserCredential value) {
        userData.add(value);
        setUserToCollection(
            value.user!.uid,
            value.user?.metadata.creationTime as DateTime,
            value.user?.metadata.lastSignInTime as DateTime);
      });
    } catch (e) {
      errorMessage.add(e.toString());
    }
  }

  void setUserToCollection(
      String uuid, DateTime creationTime, DateTime lastSignInTime) {
    FirebaseFirestore.instance.collection('users').add({
      'creationTime': creationTime,
      'lastSignInTime': lastSignInTime,
      'uid': uuid
    }).then((value) async {
      SharedPreferences prefData = await SharedPreferences.getInstance();
      prefData.setString('UserID', uuid);
    }).catchError((error) {
      errorMessage.add("Failed to add user: $error");
    });
  }

  Future<void> setIdToSharedPref(String id) async {}

  void close() {
    errorMessage.close();
    userData.close();
  }
}
