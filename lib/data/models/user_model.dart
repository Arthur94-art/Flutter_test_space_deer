import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  DateTime? creationTime;
  DateTime? lastSignInTime;
  String? notificationToken;

  UserModel(
      {this.uid,
      this.creationTime,
      this.lastSignInTime,
      this.notificationToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    creationTime = (json['creationTime'] as Timestamp).toDate();
    lastSignInTime = (json['lastSignInTime'] as Timestamp).toDate();
    notificationToken = json['notificationToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['creationTime'] = creationTime;
    data['lastSignInTime'] = lastSignInTime;
    data['notificationToken'] = notificationToken;
    return data;
  }
}
