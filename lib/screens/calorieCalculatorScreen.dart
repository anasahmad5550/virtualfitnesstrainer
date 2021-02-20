import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtualfitnesstrainer/widgets/reusableCard.dart';
import 'package:virtualfitnesstrainer/constants.dart';
import 'package:virtualfitnesstrainer/widgets/round_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'calorieResultScreen.dart';

class CalorieCalculatorScreen extends StatefulWidget {
  static const String routeid = '/Caloriecalculatorscreen';
  @override
  _CalorieCalculatorScreenState createState() =>
      _CalorieCalculatorScreenState();
}

int height = 180;
int weight = 60;
int age = 20;
bool gender = false;
double bmr;
String dropdownValue = 'little or no exercise';
List<String> list = [
  'little or no exercise',
  'light exercise/sports 1-3 days/week',
  'moderate exercise/sports 3-5 days/week',
  'hard exercise/sports 6-7 days a week',
  'very hard exercise/sports & a physical job'
];

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  String calculateCalorie() {
    if (gender) {
      //BMR for Men = 66.47 + (13.75 * weight [kg]) + (5.003 * size [cm]) − (6.755 * age [years])
      bmr = 66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age);
    } else {
      // BMR for Women = 655.1 + (9.563 * weight [kg]) + (1.85 * size [cm]) − (4.676 * age [years])
      //bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
      bmr = 655.1 + (9.563 * weight) + (1.85 * height) - (4.676 * age);
    }
    if (dropdownValue == list[0])
      return (bmr * 1.2).toStringAsFixed(0);
    else if (dropdownValue == list[1])
      return (bmr * 1.375).toStringAsFixed(0);
    else if (dropdownValue == list[2])
      return (bmr * 1.55).toStringAsFixed(0);
    else if (dropdownValue == list[3])
      return (bmr * 1.725).toStringAsFixed(0);
    else if (dropdownValue == list[4]) return (bmr * 1.9).toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    card: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'WEIGHT',
                          style: ktstyle,
                        ),
                        Text(
                          weight.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).padding.top) *
                                0.06,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onpress: () {
                                setState(() {
                                  weight--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              onpress: () {
                                setState(() {
                                  weight++;
                                });
                              },
                              icon: FontAwesomeIcons.plus,
                            ),
                          ],
                        )
                      ],
                    ),
                    colour: Colors.white,
                  ),
                ),
                Expanded(
                    child: ReusableCard(
                  card: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'AGE',
                        style: ktstyle,
                      ),
                      Text(
                        age.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).padding.top) *
                              0.06,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            onpress: () {
                              setState(() {
                                age--;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          RoundIconButton(
                            onpress: () {
                              setState(() {
                                age++;
                              });
                            },
                            icon: FontAwesomeIcons.plus,
                          ),
                        ],
                      )
                    ],
                  ),
                  colour: Colors.white,
                )),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ReusableCard(
              card: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HEIGHT',
                    style: ktstyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        height.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).padding.top) *
                              0.06,
                        ),
                      ),
                      Text('cm')
                    ],
                  ),
                  Slider(
                    value: height.toDouble(),
                    min: 120.0,
                    max: 220.0,
                    activeColor: Theme.of(context).accentColor,
                    inactiveColor: Theme.of(context).canvasColor,
                    onChanged: (double changeheightvalue) {
                      setState(() {
                        height = changeheightvalue.round();
                      });
                    },
                  )
                ],
              ),
              colour: Colors.white,
            ),
          ),
          Expanded(
            flex: 1,
            child: ReusableCard(
              card: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Activity : ',
                    style: TextStyle(
                      fontSize: width * 0.05,
                      color: Color(0xff8d8e98),
                    ),
                  ),
                  DropdownButton<String>(
                    items: list.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 11),
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).accentColor,
                    ),
                  )
                ],
              ),
              colour: Colors.white,
            ),
          ),
          Expanded(
            flex: 1,
            child: ReusableCard(
              card: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'MALE',
                    style: ktstyle,
                  ),
                  Switch.adaptive(
                      activeColor: Theme.of(context).accentColor,
                      inactiveThumbColor: Theme.of(context).accentColor,
                      inactiveTrackColor: Colors.pink.shade200,
                      value: gender,
                      onChanged: (value) {
                        setState(() {
                          print(gender);
                          gender = value;
                        });
                      }),
                  Text(
                    'FEMALE',
                    style: ktstyle,
                  ),
                ],
              ),
              colour: Colors.white,
            ),
          ),
          InkWell(
            onTap: () {
              String calorieResult = calculateCalorie();

              print(calorieResult);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return CalorieResultScreen(
                      maintianCalories: calorieResult,
                    );
                  },
                ),
              );
              //resultbmi(context)
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 40),
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).accentColor,
                  ),
                  child: Center(
                    child: Text(
                      'Calculate',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
