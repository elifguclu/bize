import 'package:bize/dbHelper/mongodb.dart';
import 'package:bize/models/post.dart';
import 'package:flutter/gestures.dart';
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
      body: SafeArea(
          child: FutureBuilder(
        future: MongoDatabase.getPost(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              var totalData = snapshot.data.length;
              //return Center(child: Text("Data found."));
              return ListView.builder(
                itemCount: totalData,
                itemBuilder: (context, index) {
                  return displayPost(post.fromJson(snapshot.data[index]));
                },
              );
            } else {
              return Center(child: Text("No data available."));
            }
          }
        },
      )),
    );
  }

  Widget displayPost(post data) {
    return SingleChildScrollView(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            //padding: const EdgeInsets.only(left: 8, right: 8),
            margin:
                const EdgeInsets.only(left: 8, right: 8, top: 15, bottom: 15),
            decoration: BoxDecoration(color: Color(0xffc2cddb)),
            child: Row(children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                width: 50,
                child: SvgPicture.asset(
                  'assets/icons/avatar.svg',
                  color: Colors.black,
                ),
              ),
              Container(
                child: Column(children: <Widget>[
                  Container(
                    child: Container(
                      alignment: Alignment.center,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      child: Text(
                        //"Elif Bakır",
                        "${data.userName} ${data.userSurname}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                ]),
              )
            ]),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.5, color: Colors.black),
                ),
                color: Color(0xffc2cddb)),
            child: Row(children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 15),
                    width: 355,
                    child: Expanded(
                      child: Text(
                        "${data.value}",
                        //"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        softWrap: false,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis, //new
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          //backgroundColor: Color(0xff877bfb),
                          // width: double.infinity,
                        ),
                        onPressed: () => {},
                        child: SvgPicture.asset(
                          'assets/icons/like.svg',
                          color: Color(0xffff006f),
                          width: 30,
                        ),
                      ),
                      Text(
                        "${data.likes}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),

                      // boşluk
                      Container(
                        width: 50,
                      ),
                      // boşluk

                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          //backgroundColor: Color(0xff877bfb),
                          // width: double.infinity,
                        ),
                        onPressed: () => {},
                        child: SvgPicture.asset(
                          'assets/icons/message-circle.svg',
                          color: Colors.black,
                          width: 30,
                        ),
                      ),
                      Text(
                        "${data.comments}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),

                      // boşluk
                      Container(
                        width: 100,
                      ),
                      // boşluk

                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          //backgroundColor: Color(0xff877bfb),
                          // width: double.infinity,
                        ),
                        onPressed: () => {},
                        child: SvgPicture.asset(
                          'assets/icons/save.svg',
                          color: Colors.black,
                          width: 30,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ]),
          ),
        ],
      ),
    ));
  }
}
