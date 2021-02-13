import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HomeContainer extends StatelessWidget {
  final String imgurl;
  final String icnimgurl;
  final String title;
  final Function onpress;
  HomeContainer({this.title, this.icnimgurl, this.imgurl, this.onpress});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onpress,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          margin: const EdgeInsets.all(12.0),
          height: (MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top) *
              0.24,
          //width: MediaQuery.of(context).size.width * 0.45,
          //color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                icnimgurl,
                height: 60,
                width: 60,
              ),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Raleway',
                ),
              ),
              Image.asset(imgurl),
            ],
          ),
        ),
      ),
    );
  }
}
