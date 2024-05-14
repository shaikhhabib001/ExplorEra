import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? email;
  String? userName;
  String? password;
  String? phoneNumber;

  User({
    this.email,
    this.userName,
    this.password,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        userName: json['userName'],
        password: json['password'],
        phoneNumber: json['phoneNumber'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'userName': userName,
        'password': password,
        'phoneNumber': phoneNumber,
      };
}
