import 'package:bize/constants.dart';
import 'package:bize/dbHelper/mongodb.dart';
import 'package:bize/main.dart';
import 'package:bize/models/user.dart';
import 'package:bize/screens/Home.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bize/utils/BottomBarMenu.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await MongoDatabase.connect();
  runApp(const SignUp());
}

class SignUp extends StatelessWidget {
  const SignUp({super.key});

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
        scaffoldBackgroundColor: Color(0xFF0B0B0B),
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

  String textEmail = "";
  String textPassword = "";
  String textName = "";
  String textSurname = "";

  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();
  var nameController = new TextEditingController();
  var surnameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                margin: const EdgeInsets.only(left: 36, right: 36, top: 15),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      // contentPadding: EdgeInsets.only(left: 2),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff3a588d), width: 2.0)),
                      border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff3a588d), width: 2.0)),
                      labelText: TextConstants.name,
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          color: Color(0xff3a588d))),
                  onChanged: (text) => {textName = text},
                ),
              ),
              Container(
                width: double.infinity,
                // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                margin: const EdgeInsets.only(left: 36, right: 36, top: 15),
                child: TextFormField(
                  controller: surnameController,
                  decoration: const InputDecoration(
                      // contentPadding: EdgeInsets.only(left: 2),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff3a588d), width: 2.0)),
                      border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff3a588d), width: 2.0)),
                      labelText: TextConstants.surname,
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          color: Color(0xff3a588d))),
                  onChanged: (text) => {textSurname = text},
                ),
              ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8)),
                  onPressed: () {
                    _insertUserData(nameController.text, surnameController.text,
                        emailController.text, passwordController.text);
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => const App())));
                  },
                  child: const Text(
                    TextConstants.signUp,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
            ]),
      )),
    ));
  }

  Future<void> _insertUserData(
      String name, String surname, String email, String password) async {
    var _id = M.ObjectId();
    DateTime now = new DateTime.now();
    final data = user(
        id: _id,
        email: email,
        password: password,
        name: name,
        surname: surname,
        createdAt: now.millisecondsSinceEpoch,
        updatedAt: now.millisecondsSinceEpoch);
    var result = await MongoDatabase.insertUser(data);

    showModal(context, result);

    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text("Inserted ID " + _id.$oid)));
    _clearAll();
  }

  void _clearAll() {
    emailController.text = "";
    passwordController.text = "";
  }
}
