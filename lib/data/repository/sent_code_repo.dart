import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class SentCodeRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  BehaviorSubject errorMessage = BehaviorSubject.seeded('');
  BehaviorSubject userData = BehaviorSubject.seeded(UserCredential);

  Future<void> sentCode(String verificationId, String controllerText) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: controllerText,
    );
    try {
      await _auth.signInWithCredential(credential).then((value) {
        userData.add(value);
      });
    } catch (e) {
      errorMessage.add(e.toString());
    }
  }

  void close() {
    errorMessage.close();
    userData.close();
  }
}
