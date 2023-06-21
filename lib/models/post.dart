import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  ObjectId id;
  ObjectId userId;
  String userName;
  String userSurname;
  String post;
  int likes;
  int comments;
  int createdAt;
  int updatedAt;

  Post({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userSurname,
    required this.post,
    required this.likes,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        userId: json["user_id"],
        userName: json["user_name"],
        userSurname: json["user_surname"],
        post: json["post"],
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
        "post": post,
        "likes": likes,
        "comments": comments,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
