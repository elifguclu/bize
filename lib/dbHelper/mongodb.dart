import 'dart:developer';

import 'package:bize/dbHelper/constant.dart';
import 'package:bize/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection, postCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
    postCollection = db.collection(POST_COLLECTION);
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

  static Future<void> getUser(userQuery data) async {
    try {
      var user = await userCollection.findOne({
        'email': data.email,
        'password': data.password
      }); // kullanıcı email ve password eşleşmesi yapıyoruz.
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

//   [
//   {
//     $sort:
//       /**
//        * specifications: The fields to
//        *   include or exclude.
//        */
//       {
//         createdAt: -1,
//       },
//   },
// ] postların tarihe göre sıralanması

// let input = "buzz";

// db.collectionName.find(
//     {
//         $or: [
//             { $text: { $search: input } },
//             { _id: { $exists: true } }
//         ]
//     },
//     {
//         "foo": 1,
//         score: { $meta: "textScore" }
//     }
// ).sort({
//     score: { $meta: "textScore" }
// });
}
