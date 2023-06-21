import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Prize 1"),
        content: Container(
          height: 64,
          child: Column(
            children: const [
              Text(
                "prize1",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "6",
                style: TextStyle(color: Colors.green),
              )
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.bodyText2,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Colors.grey),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'VAZGEÇ',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Colors.purple),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'SATIN AL',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

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
      //body: SafeArea(child: Text('Home Page')),
      body: SingleChildScrollView(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 128,
              height: 96,
              margin: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.purple),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Puanlarım",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    "1000",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
