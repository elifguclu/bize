import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

user userFromJson(String str) => user.fromJson(json.decode(str));

String userToJson(user data) => json.encode(data.toJson());

class user {
  ObjectId id;
  String email;
  String password;
  String name;
  String surname;
  int createdAt;
  int updatedAt;

  user({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.createdAt,
    required this.updatedAt,
  });

  factory user.fromJson(Map<String, dynamic> json) => user(
      id: json["_id"],
      email: json["email"],
      password: json["password"],
      name: json["name"],
      surname: json["surname"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "password": password,
        "name": name,
        "surname": surname,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class userQuery {
  String email;
  String password;

  userQuery({
    required this.email,
    required this.password,
  });

  factory userQuery.fromJson(Map<String, dynamic> json) => userQuery(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
