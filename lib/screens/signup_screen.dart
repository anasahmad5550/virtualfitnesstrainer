import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'size_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      SizeConfig().init(constraints);
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FYP Signup Page',
        theme: ThemeData.light(),
        home: SignUpPage(),
      );
    });
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0e1d22),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Opacity(
                opacity: 0.3,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/home.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6 * SizeConfig.heightMultiplier),
                    topRight: Radius.circular(6 * SizeConfig.heightMultiplier),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    5.555 * SizeConfig.imageSizeMultiplier,
                    2.5 * SizeConfig.heightMultiplier,
                    5.555 * SizeConfig.imageSizeMultiplier,
                    0.0 * SizeConfig.heightMultiplier,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        text("First Name", 15.0, MainAxisAlignment.start,
                            FontWeight.w700, Colors.black, null),
                        textField("Enter First Name", false,
                            (String fnameText) {
                          //code here
                        }),
                        text("Username", 15.0, MainAxisAlignment.start,
                            FontWeight.w700, Colors.black, null),
                        textField("Enter Username", false, (String unameText) {
                          //code here
                        }),
                        text("Password", 15.0, MainAxisAlignment.start,
                            FontWeight.w700, Colors.black, null),
                        textField("Enter Password", true, (String passText) {
                          //code here
                        }),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 2 * SizeConfig.heightMultiplier,
                            horizontal: 3.333 * SizeConfig.imageSizeMultiplier,
                          ),
                          child: ButtonTheme(
                            minWidth: 44.444 * SizeConfig.imageSizeMultiplier,
                            height: 7.2 * SizeConfig.heightMultiplier,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    2.2 * SizeConfig.heightMultiplier),
                              ),
                              color: Colors.pink,

                              onPressed: () {}, //code here

                              child: Text(
                                "Signup",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        text("OR", 13.0, MainAxisAlignment.center,
                            FontWeight.bold, Colors.black, null),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            signupIcon(
                              activeColour: Colors.blue[900],
                              disableColour: Colors.blue,
                              icon: MdiIcons.facebook,
                              txtToDisplay: "Signup with Facebook",
                              onPressed: () {}, //code here
                            ),
                            signupIcon(
                              activeColour: Colors.red[900],
                              disableColour: Colors.red,
                              icon: MdiIcons.google,
                              txtToDisplay: "Signup with Google",
                              onPressed: () {}, //code here
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
