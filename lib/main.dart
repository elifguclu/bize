import 'package:bize/constants.dart';
import 'package:bize/dbHelper/mongodb.dart';
import 'package:bize/screens/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bize/utils/BottomBarMenu.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      title: 'Bize',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.white),
          subtitle1: TextStyle(color: Colors.white),
          subtitle2: TextStyle(color: Colors.white),
        ),
        scaffoldBackgroundColor: Color(0xFF0B0B0B), //0xFF0B0B0B
      ),
      home: const MyHomePage(title: 'Bize App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
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

  String email = "";
  String password = "";

  String textEmail = "";
  String textPassword = "";

  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 36),
              child: const Text(
                TextConstants.userLogin,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              )),
          Container(
            width: double.infinity,
            // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            margin: const EdgeInsets.only(left: 36, right: 36, top: 15),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  // contentPadding: EdgeInsets.only(left: 2),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff3a588d), width: 2.0)),
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff3a588d), width: 2.0)),
                  labelText: TextConstants.email,
                  labelStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      color: Color(0xff3a588d))),
              onChanged: (text) => {textEmail = text},
            ),
          ),
          Container(
            width: double.infinity,
            // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            margin: const EdgeInsets.only(left: 36, right: 36),
            child: TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                  // contentPadding: EdgeInsets.only(left: 2),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff3a588d), width: 2.0)),
                  border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff3a588d), width: 2.0)),
                  labelText: TextConstants.password,
                  labelStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      color: Color(0xff3a588d))),
              onChanged: (text) => {textPassword = text},
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 36, right: 36, top: 100),
            child: TextButton(
              style: TextButton.styleFrom(
                  fixedSize: Size.fromHeight(50),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xffff006f),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
              onPressed: () async {
                if (emailController.text == '' &&
                    passwordController.text == '') {
                  showModal(context, 'Bilgilerinizi kontrol edin.');
                } else {
                  var result = await _login(
                      emailController.text, passwordController.text);
                  if (result == 'Successfully') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BottomBarMenu(email: '${emailController.text}')),
                      // const BottomBarMenu(email: 'a')),
                    );
                  } else {
                    showModal(context, 'Bilgilerinizi kontrol edin.');
                  }
                }
              },
              child: const Text(
                TextConstants.login,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
            ),
          ),
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const SignUp())));
                  },
                  child: const Text(
                    TextConstants.signUp,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontFamily: 'Montserrat'),
                  )))
        ]),
      )),
    ));
  }

  Future<String> _login(String email, String password) async {
    final data = userQuery(email: email, password: password);
    var result = await MongoDatabase.login(data);
    //_clearAll();
    return result;
  }

  // Future<void> _getUser(String email, String password) async {
  //   final data = userQuery(email: email, password: password);
  //   var result = await MongoDatabase.getUser(data);
  //   _clearAll();
  //   return result;
  // }

  void _clearAll() {
    emailController.text = "";
    passwordController.text = "";
  }
}
