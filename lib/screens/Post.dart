import 'package:bize/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class Post extends StatefulWidget {
  const Post({super.key});
  // final String user_email;
  // const Post({required this.user_email});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  var postController = new TextEditingController();
  String post = "";

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
                        onChanged: (text) => {post = text},
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
                      // if (emailController.text == '' &&
                      //     passwordController.text == '') {
                      //   showModal(context, 'Bilgilerinizi kontrol edin.');
                      // } else {
                      //   var result = await _login(
                      //       emailController.text, passwordController.text);
                      //   if (result == 'Successfully') {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const BottomBarMenu()),
                      //     );
                      //   } else {
                      //     showModal(context, 'Bilgilerinizi kontrol edin.');
                      //   }
                      // }
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

  // Future<String> _login(String email, String password) async {
  //   final data = userQuery(email: email, password: password);
  //   var result = await MongoDatabase.login(data);
  //   _clearAll();
  //   return result;
  // }

  // void _clearAll() {
  //   emailController.text = "";
  //   passwordController.text = "";
  // }
}
