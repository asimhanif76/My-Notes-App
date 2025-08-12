class UserModel {
  String name;
  String userName;
  String email;
  String? uid;
  UserModel({
    required this.name,
    required this.userName,
    required this.email,
     this.uid,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'UserName': userName,
      'email': email,
      'uid': uid,
    };
  }
}
