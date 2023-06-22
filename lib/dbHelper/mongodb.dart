import 'dart:developer';

import 'package:bize/dbHelper/constant.dart';
import 'package:bize/models/user.dart';
import 'package:bize/models/post.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection, postCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    postCollection = db.collection(POST_COLLECTION);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<String> insertUser(user data) async {
    try {
      var user = await userCollection.findOne({
        'email': data.email,
      }); // kullanıcı varsa eklemez.
      if (user != null) {
        return 'The user already exists.';
      } else {
        var result = await userCollection.insertOne(data.toJson());
        if (result.isSuccess) {
          return 'Added successfully.';
        } else {
          return 'Something wrong while user inserting data.';
        }
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<String> login(userQuery data) async {
    try {
      var user = await userCollection.findOne({
        'email': data.email,
        'password': data.password
      }); // kullanıcı email ve password eşleşmesi yapıyoruz.
      if (user != null) {
        return 'Successfully';
      } else {
        return 'Bilgilerinizi kontrol edin. ';
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<void> getUser(String email) async {
    try {
      var user = await userCollection.findOne(
          {'email': email}); // kullanıcı email ve password eşleşmesi yapıyoruz.
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<String> insertPost(String email, post data) async {
    try {
      var user = await userCollection
          .findOne({'email': email}); // kullanıcı varsa eklemez.
      if (user == null) {
        return 'Something wrong.';
      } else {
        data.userId = user['_id'];
        data.userName = user['name'];
        data.userSurname = user['surname'];
        var result = await postCollection.insertOne(data.toJson());
        if (result.isSuccess) {
          return 'Successfully';
        } else {
          return 'Something wrong while post inserting data.';
        }
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  //static Future<List<Map<String, dynamic>>?> getPost() async {
  static Future<List> getPost() async {
    // final postData = await postCollection.find().sort({
    //   {
    //     'createdAt': -1, // sıralama yapıyoruz. postlar yeniden eskiye göre
    //   }
    // }).toList();

    final postData = await postCollection.find().toList();

    var reversedList = new List.from(postData.reversed);

    // final postData = await postCollection.aggregate([
    //   {
    //     'project': {
    //       "user_name": 1,
    //       "user_surname": 1,
    //       "value": 1,
    //       "likes": 1,
    //       "comments": 1
    //     }
    //   },
    //   {
    //     'sort': {'createdAt': -1}
    //   }
    // ]);
    return reversedList;
  }
}
