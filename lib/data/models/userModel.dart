
class UserModel {
  String? uid;
  DateTime? creationTime;
  DateTime? lastSignInTime;

  UserModel({this.uid, this.creationTime, this.lastSignInTime});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    creationTime = json['creationTime'];
    lastSignInTime = json['lastSignInTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['creationTime'] = creationTime;
    data['lastSignInTime'] = lastSignInTime;
    return data;
  }
}