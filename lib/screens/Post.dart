import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class Post extends StatefulWidget {
  const Post({super.key});
  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
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
          padding: EdgeInsets.all(170),
          child: SvgPicture.asset(
            "assets/icons/logo.svg",
            color: Color(0xFF0B0B0B), //0xffc2cddb
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: Text('Post Page')),
    );
  }
}
