import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class Adaptiveflatbutton extends StatelessWidget {
  final Function handler;
  final text;
  Adaptiveflatbutton({this.text, this.handler});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(text),
            onPressed: handler,
          )
        : FlatButton(
            onPressed: handler,
            child: Text(text),
            textColor: Theme.of(context).accentColor,
          );
  }
}
