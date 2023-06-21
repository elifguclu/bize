import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

post postFromJson(String str) => post.fromJson(json.decode(str));

String postToJson(post data) => json.encode(data.toJson());

class post {
  ObjectId id;
  ObjectId userId;
  String userName;
  String userSurname;
  String value;
  int likes;
  int comments;
  int createdAt;
  int updatedAt;

  post({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userSurname,
    required this.value,
    required this.likes,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory post.fromJson(Map<String, dynamic> json) => post(
        id: json["_id"],
        userId: json["user_id"],
        userName: json["user_name"],
        userSurname: json["user_surname"],
        value: json["value"],
        likes: json["likes"],
        comments: json["comments"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "user_name": userName,
        "user_surname": userSurname,
        "value": value,
        "likes": likes,
        "comments": comments,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
