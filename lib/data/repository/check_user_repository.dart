import 'package:shared_preferences/shared_preferences.dart';

abstract class CheckUser {
  Future<bool> isUserLogged();
}

class CheckUserRepository extends CheckUser {
  @override
  Future<bool> isUserLogged() async {
    var pref = await SharedPreferences.getInstance();
    String userID = pref.getString('UserID') ?? '';
    return userID.isNotEmpty;
  }
}
