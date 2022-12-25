import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/subjects.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  BehaviorSubject errorMessage = BehaviorSubject.seeded('');
  BehaviorSubject verificationID = BehaviorSubject.seeded('');
  BehaviorSubject isShowLoading = BehaviorSubject.seeded(true);

  Future<void> signUpWithPhone(String phoneNumber) async {
    isShowLoading.add(false);
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        isShowLoading.add(true);
      },
      verificationFailed: (e) {
        errorMessage.add(e.message);
        isShowLoading.add(true);
      },
      codeSent: ((String verificationId, int? resendToken) async {
        verificationID.add(verificationId);
        isShowLoading.add(true);
      }),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void close() {
    errorMessage.close();
    verificationID.close();
    isShowLoading.close();
  }
}
