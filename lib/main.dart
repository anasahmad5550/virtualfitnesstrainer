import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtualfitnesstrainer/Provider/ReminderList.dart';
import 'package:virtualfitnesstrainer/screens/login_screen.dart' as lg;
import 'screens/homeScreen.dart';
import 'screens/bmiCalculatorScreen.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'helpers/saveWorkouts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ReminderList(),
        ),
        ChangeNotifierProvider.value(
          value: Saveworkouts(),
        )
      ],
      child: MaterialApp(
        title: 'VFT',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(29, 14, 54, 1),
          accentColor: Color(0xffFB376C),
          canvasColor: Color(0xffF2F2F3),
          //fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold),
              ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) return HomeScreen();
            return lg.MyApp();
          },
        ),
        routes: {
          //   '/': (ctx) => TabsScreen(),
          // '/BmiCalculaorScreen' :(ctx)=>BmiCalculaorScreen(),
          BmiCalculaorScreen.routeid: (ctx) => BmiCalculaorScreen(),
        },
      ),
    );
  }
}
