import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        focusColor: Colors.blue,
        splashColor: Colors.pink,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          margin: const EdgeInsets.all(12.0),
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
