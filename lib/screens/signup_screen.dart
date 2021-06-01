import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'homeScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:virtualfitnesstrainer/models/helperFunctions.dart';

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
  String _name;
  String _email;
  String _password;

  bool isSignUpLoading = false;
  UserCredential _user;
  final googleSignIn = GoogleSignIn();

  static final FacebookLogin facebookSignIn = FacebookLogin();

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _loginWithFacebook() async {
    setState(() {
      isSignUpLoading = true;
    });
    try {
      final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

      setState(() {
        isSignUpLoading = false;
      });
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final FacebookAccessToken accessToken = result.accessToken;
          final AuthCredential credential =
              FacebookAuthProvider.credential(accessToken.token);

          //User Credential to Sign in with Firebase

          _user = await _auth.signInWithCredential(credential);
          //final result1 = await f.signInWithCredentail(credential);

          _AddExtraData();
          RouteToHomeScreen();
          print('${_user.user.displayName} is now logged in');
          //print(_result1.user.photoURL);

          print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
          break;
        case FacebookLoginStatus.cancelledByUser:
          print('Login cancelled by the user.');
          break;
        case FacebookLoginStatus.error:
          print('Something went wrong with the login process.\n'
              'Here\'s the error Facebook gave us: ${result.errorMessage}');
          break;
      }
    } on FirebaseAuthException catch (e) {
      ExceptionMessafge(e);
    } catch (e) {
      print(e);
    }
  }

  void ExceptionMessafge(FirebaseAuthException e) {
    if (e.code == 'weak-password') {
      Helper().showErrorDialog('The password provided is too weak.', context);
    } else if (e.code == 'email-already-in-use') {
      Helper().showErrorDialog(
          'The account already exists for that email.', context);
    }
  }

  //Check all values that user enter in name , email and password field
  void checkValues() {
    if (_email.isEmpty || !_email.contains('@')) {
      Helper().showErrorDialog("Invalid E-mail", context);
      return;
    }
    if (_password.isEmpty || _password.length < 5) {
      Helper().showErrorDialog(
          "Password is too short.Password should be minimum 6 characters",
          context);
      return;
    }
    if (_name.isEmpty) {
      Helper().showErrorDialog("Name can't be empty", context);
      return;
    }
  }

  Future<void> _loginWithEmailAndPassword() async {
    checkValues();

    setState(() {
      isSignUpLoading = true;
    });

    try {
      _user = await _auth.createUserWithEmailAndPassword(
          email: _email.trim(), password: _password);

      _AddExtraData();
      RouteToHomeScreen();
    } on FirebaseAuthException catch (e) {
      ExceptionMessafge(e);
    } catch (error) {
      print(error);
      Helper().showErrorDialog(
          "An Error has occurred. Please check your internet connection and try again later ",
          context);
    } finally {
      setState(() {
        isSignUpLoading = false;
      });
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      isSignUpLoading = true;
    });
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      _user = await _auth.signInWithCredential(credential);
      _AddExtraData();
    } on FirebaseAuthException catch (e) {
      ExceptionMessafge(e);
    } catch (e) {
      print(e);
    }
    setState(() {
      isSignUpLoading = false;
    });
    RouteToHomeScreen();
  }

  Future<void> _AddExtraData() async {
    final a = await FirebaseFirestore.instance
        .collection("users")
        .doc(_user.user.uid)
        .set({"name": _user.user.displayName.trim()});
    return a;
  }

  void RouteToHomeScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) {
        return HomeScreen();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0e1d22),
      body: SafeArea(
        child: isSignUpLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).accentColor,
                ),
              )
            : Column(
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
                          topLeft:
                              Radius.circular(6 * SizeConfig.heightMultiplier),
                          topRight:
                              Radius.circular(6 * SizeConfig.heightMultiplier),
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
                              Helper().text(
                                  "Name",
                                  15.0,
                                  MainAxisAlignment.start,
                                  FontWeight.w700,
                                  Colors.black,
                                  null),
                              Helper().textField("Enter Name", false,
                                  (String fnameText) {
                                _name = fnameText;
                              }),
                              Helper().text(
                                  "E-mail",
                                  15.0,
                                  MainAxisAlignment.start,
                                  FontWeight.w700,
                                  Colors.black,
                                  null),
                              Helper().textField("Enter E-mail", false,
                                  (String email) {
                                _email = email;
                              }),
                              Helper().text(
                                  "Password",
                                  15.0,
                                  MainAxisAlignment.start,
                                  FontWeight.w700,
                                  Colors.black,
                                  null),
                              Helper().textField("Enter Password", true,
                                  (String passText) {
                                _password = passText;
                              }),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 2 * SizeConfig.heightMultiplier,
                                  horizontal:
                                      3.333 * SizeConfig.imageSizeMultiplier,
                                ),
                                child: ButtonTheme(
                                  minWidth:
                                      44.444 * SizeConfig.imageSizeMultiplier,
                                  height: 7.2 * SizeConfig.heightMultiplier,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Theme.of(context).accentColor),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                2.2 *
                                                    SizeConfig
                                                        .heightMultiplier),
                                          ),
                                        )),

                                    onPressed:
                                        _loginWithEmailAndPassword, //code here

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
                              Helper().text(
                                  "OR",
                                  13.0,
                                  MainAxisAlignment.center,
                                  FontWeight.bold,
                                  Colors.black,
                                  null),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Helper().signupIcon(
                                    activeColour: Colors.blue[900],
                                    disableColour: Colors.blue,
                                    icon: MdiIcons.facebook,
                                    txtToDisplay: "Signup with Facebook",
                                    onPressed: _loginWithFacebook, //code here
                                  ),
                                  Helper().signupIcon(
                                    activeColour: Colors.red[900],
                                    disableColour: Colors.red,
                                    icon: MdiIcons.google,
                                    txtToDisplay: "Signup with Google",
                                    onPressed: _loginWithGoogle, //code here
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
