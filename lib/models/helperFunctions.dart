import 'package:flutter/material.dart';
import 'package:virtualfitnesstrainer/screens/size_config.dart';

class Helper {
  Row text(String txt, double fontsize, MainAxisAlignment align, FontWeight fw,
      Color colour, TextDecoration td) {
    return Row(
      mainAxisAlignment: align,
      children: <Widget>[
        Text(
          "$txt",
          style: TextStyle(
              decoration: td,
              fontSize: (fontsize / 8.5) * SizeConfig.textMultiplier,
              fontWeight: fw,
              color: colour),
        ),
      ],
    );
  }

  Column signupIcon(
      {Color activeColour,
      Color disableColour,
      IconData icon,
      String txtToDisplay,
      Function onPressed}) {
    return Column(
      children: <Widget>[
        IconButton(
          disabledColor: disableColour,
          color: activeColour,
          iconSize: 11.111 * SizeConfig.imageSizeMultiplier,
          icon: Icon(
            icon,
          ),
          onPressed: onPressed,
        ),
        text("$txtToDisplay", 12.0, MainAxisAlignment.center, FontWeight.bold,
            Colors.black, null),
      ],
    );
  }

  Padding textField(String hintText, bool obscureText, Function onChanged) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 1.5 * SizeConfig.heightMultiplier,
      ),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: '$hintText',
          //isDense: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 0.8 * SizeConfig.heightMultiplier,
            horizontal: 1.6 * SizeConfig.imageSizeMultiplier,
          ),
        ),
        obscureText: obscureText,

        onChanged: onChanged, //code here
      ),
    );
  }

  void showErrorDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Widget textfieldForProfileScreen({String hintText = ""}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            letterSpacing: 2,
            color: Color(0xffFB376C),
            fontWeight: FontWeight.bold,
          ),
          fillColor: Colors.white30,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
