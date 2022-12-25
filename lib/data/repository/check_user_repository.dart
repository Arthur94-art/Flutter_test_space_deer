import 'package:shared_preferences/shared_preferences.dart';

class CheckUserRepository {
  Future<bool> isUserLogged() async {
    var pref = await SharedPreferences.getInstance();
    String userID = pref.getString('UserID') ?? '';
    return userID.isNotEmpty;
  }
}
