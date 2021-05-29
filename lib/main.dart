import 'package:flutter/material.dart';
import 'package:virtualfitnesstrainer/Provider/ReminderList.dart';
import 'package:virtualfitnesstrainer/screens/login_screen.dart' as lg;
import 'screens/homeScreen.dart';
import 'screens/bmiCalculatorScreen.dart';
import 'package:provider/provider.dart';
import 'models/reminder.dart';
import 'package:virtualfitnesstrainer/screens/signup_screen.dart' as su;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReminderList(),
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
        home: su.MyApp(),
        routes: {
          //   '/': (ctx) => TabsScreen(),
          // '/BmiCalculaorScreen' :(ctx)=>BmiCalculaorScreen(),
          BmiCalculaorScreen.routeid: (ctx) => BmiCalculaorScreen(),

          //   MealDetailScreen.routeid: (ctx) => MealDetailScreen()
        },
      ),
    );
  }
}
