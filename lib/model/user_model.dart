// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppUser {
  String email;
  String? id;
  String? imageUrl;
  String userName;
  String phoneNumer;
  AppUser(
      {required this.email,
      // required this.id ,
      required this.userName,
      required this.phoneNumer,
      this.id,
      this.imageUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'userName': userName,
      'phoneNumer': phoneNumer,
      'imageUrl': imageUrl,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      email: map['email'] ?? '',
      userName: map['userName'] ?? '',
      phoneNumer: map['phoneNumer'] ?? '',
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
