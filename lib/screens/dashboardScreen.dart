import 'package:flutter/material.dart';

import 'package:virtualfitnesstrainer/widgets/homeContainers.dart';
import 'bmiCalculatorScreen.dart';
import 'reminderScreen.dart';

class Dashboard extends StatelessWidget {
  void pushbmi(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return BmiCalculaorScreen();
    }));
    // Navigator.of(context).pushNamed(BmiCalculaorScreen.routeid);
  }

  void pushreminder(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return Reminder_list_Screen();
    }));
    // Navigator.of(context).pushNamed(BmiCalculaorScreen.routeid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          SafeArea(
            child: Container(
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top) *
                  0.31,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'images/home.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    colorBlendMode: BlendMode.colorBurn,
                  ),
                  Container(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        0.25,
                    width: MediaQuery.of(context).size.width * 0.7,
                    //margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                    decoration: new BoxDecoration(
                      color: Colors.white30,
                      border: Border.all(color: Colors.black, width: 0.0),
                      borderRadius:
                          new BorderRadius.all(Radius.elliptical(200, 150)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Meal ',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              '10:05 am',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink),
                            ),
                          ],
                        ),
                        Text(
                          'Upcoming Reminder',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              // height: (MediaQuery.of(context).size.height -
              //         MediaQuery.of(context).padding.top) *
              //     0.61,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                border: Border.all(color: Theme.of(context).canvasColor),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        0.015,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeContainer(
                          title: 'Exercises',
                          icnimgurl: 'images/icn1.png',
                          imgurl: 'images/image1.png',
                        ),
                        HomeContainer(
                          onpress: () => pushreminder(context),
                          title: 'Reminder',
                          icnimgurl: 'images/icn4.png',
                          imgurl: 'images/image2.png',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HomeContainer(
                          title: 'Diet Plan',
                          icnimgurl: 'images/icn2.png',
                          imgurl: 'images/image3.png',
                        ),
                        HomeContainer(
                          onpress: () => pushbmi(context),
                          title: 'Bmi',
                          icnimgurl: 'images/icn3.png',
                          imgurl: 'images/image4.png',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        0.015,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
