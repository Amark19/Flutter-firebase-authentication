class UserModel {
  String? uid;
  String? email;
  String? fname;

  UserModel({this.uid, this.email, this.fname});

  //data from server
  factory UserModel.fromMap(map) {
    return UserModel(uid: map['uid'], email: map['email'], fname: map['fname']);
  }
}
