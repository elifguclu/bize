import 'package:bize/constants.dart';
import 'package:bize/dbHelper/mongodb.dart';
import 'package:bize/models/post.dart';
import 'package:bize/screens/Home.dart';
import 'package:bize/utils/BottomBarMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class Post extends StatefulWidget {
  //const Post({super.key});
  final String email;
  const Post({required this.email});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  void showModal(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          content: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Color(0xffff006f)),
          ),
          actions: <Widget>[
            Container(
                width: double.infinity,
                child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xff877bfb),
                      // width: double.infinity,
                    ),
                    onPressed: () => {Navigator.of(context).pop()},
                    child: const Text(
                      "Kapat",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    )))
          ]),
    );
  }

  var postController = new TextEditingController();
  String postValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc2cddb),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Container(
          //padding: EdgeInsets.all(170),
          width: 58,
          child: SvgPicture.asset(
            "assets/icons/logo.svg",
            color: Color(0xFF0B0B0B), //0xffc2cddb
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 8, top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: postController,
                        style: TextStyle(color: Color(0xff3a588d)), //0xff3a588d
                        minLines:
                            10, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                            // contentPadding: EdgeInsets.only(left: 2),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF0B0B0B), width: 2.0)),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF0B0B0B), width: 2.0)),
                            labelText: 'Write something here...',
                            labelStyle: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                color: Color(0xFF0B0B0B))),
                        onChanged: (text) => {postValue = text},
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 36, right: 36, top: 70),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        fixedSize: Size.fromHeight(50),
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xffff006f),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8)),
                    onPressed: () async {
                      // widget.user_id
                      if (postController.text == '') {
                        showModal(context, 'Bilgilerinizi kontrol edin.');
                      } else {
                        var result =
                            await _post(widget.email, postController.text);
                        if (result == 'Successfully') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BottomBarMenu(email: '${widget.email}')),
                          );
                        } else {
                          showModal(context, 'Bilgilerinizi kontrol edin.');
                        }
                      }
                    },
                    child: const Text(
                      TextConstants.post,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Future<String> _post(String email, String postValue) async {
    var _id = M.ObjectId();
    DateTime now = new DateTime.now();

    //var user_detail = await MongoDatabase.getUser('a');

    final data = post(
        id: _id,
        userId: _id,
        userName: '',
        userSurname: '',
        value: postValue,
        likes: 0,
        comments: 0,
        createdAt: now.millisecondsSinceEpoch,
        updatedAt: now.millisecondsSinceEpoch);
    var result = await MongoDatabase.insertPost(email, data);
    _clearAll();
    return result;
  }

  void _clearAll() {
    postController.text = "";
  }
}
