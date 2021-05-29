import 'package:flutter/material.dart';
import 'size_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(constraints);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FYP Login Page',
          theme: ThemeData.light(),
          home: LogInPage(),
        );
      },
    );
  }
}

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
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

  Padding textfield(String hintText, bool obscureText, Function fn) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 2 * SizeConfig.heightMultiplier,
      ),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: '$hintText',
        ),
        obscureText: obscureText,

        onChanged: fn, //code here
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
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6 * SizeConfig.heightMultiplier),
                    topRight: Radius.circular(6 * SizeConfig.heightMultiplier),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.0 * SizeConfig.imageSizeMultiplier,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 6 * SizeConfig.heightMultiplier),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          text("Username", 18.0, MainAxisAlignment.start,
                              FontWeight.w500, Colors.black, null),
                          textfield("Enter ID", false, (id) {
                            //code here
                          }),
                          text("Password", 18.0, MainAxisAlignment.start,
                              FontWeight.w500, Colors.black, null),
                          textfield("Enter Password", true, (password) {
                            //code here
                          }),
                          GestureDetector(
                            onTap: () {}, //code here

                            child: text(
                                "Forgot Password?",
                                12.0,
                                MainAxisAlignment.end,
                                FontWeight.w300,
                                Colors.black,
                                null),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 2 * SizeConfig.heightMultiplier,
                              horizontal:
                                  3.333 * SizeConfig.imageSizeMultiplier,
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
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          text(
                              "Dont have account?",
                              12.0,
                              MainAxisAlignment.center,
                              FontWeight.w300,
                              Colors.black,
                              null),
                          GestureDetector(
                            onTap: () {}, //code here
                            child: text(
                                "Create Account",
                                12.0,
                                MainAxisAlignment.center,
                                FontWeight.w300,
                                Colors.black,
                                TextDecoration.underline),
                          ),
                        ],
                      ),
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
