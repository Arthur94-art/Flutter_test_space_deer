import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SentCode {
  Future<void> sentCode(String verificationId, String controllerText);
  void setUserToCollection(String uuid, DateTime creationTime,
      DateTime lastSignInTime, String notificationToken);
  void close();
}

class SentCodeRepository extends SentCode {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  BehaviorSubject errorMessage = BehaviorSubject.seeded('');
  BehaviorSubject<UserCredential> userData = BehaviorSubject();
  @override
  Future<void> sentCode(String verificationId, String controllerText) async {
    final String notificationToken =
        await _messaging.getToken().then((value) => value) ?? '';
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
            value.user?.metadata.lastSignInTime as DateTime,
            notificationToken);
      });
    } catch (e) {
      errorMessage.add(e.toString());
    }
  }

  @override
  void setUserToCollection(String uuid, DateTime creationTime,
      DateTime lastSignInTime, String notificationToken) {
    FirebaseFirestore.instance.collection('users').add({
      'creationTime': creationTime,
      'lastSignInTime': lastSignInTime,
      'uid': uuid,
      'notificationToken': notificationToken
    }).then((value) async {
      SharedPreferences prefData = await SharedPreferences.getInstance();
      prefData.setString('UserID', uuid);
    }).catchError((error) {
      errorMessage.add("Failed to add user: $error");
    });
  }

  @override
  void close() {
    errorMessage.close();
    userData.close();
  }
}
