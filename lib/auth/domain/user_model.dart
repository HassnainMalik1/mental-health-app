import 'dart:convert';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String photoUrl;
  
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.photoUrl,
  });
  


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'uid': uid});
    result.addAll({'email': email});
    result.addAll({'name': name});
    result.addAll({'photoUrl': photoUrl});
  
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
