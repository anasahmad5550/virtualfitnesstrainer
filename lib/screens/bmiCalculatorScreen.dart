import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtualfitnesstrainer/widgets/reusableCard.dart';
import 'package:virtualfitnesstrainer/constants.dart';
import 'package:virtualfitnesstrainer/widgets/round_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'bmiResultScreen.dart';
import 'package:virtualfitnesstrainer/helpers/calculateBmi.dart';

class BmiCalculaorScreen extends StatefulWidget {
  static const String routeid = '/bmicalculatorscreen';
  @override
  _BmiCalculaorScreenState createState() => _BmiCalculaorScreenState();
}

int height = 180;
int weight = 60;
int age = 20;
bool gender = false;

class _BmiCalculaorScreenState extends State<BmiCalculaorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    card: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
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
                      const Text(
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
            child: ReusableCard(
              card: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
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
                      const Text('cm')
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
            child: ReusableCard(
              card: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
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
                          gender = value;
                        });
                      }),
                  const Text(
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
              Calculatebmi bmi = Calculatebmi(height: height, wight: weight);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return BmiResult(
                      result: bmi.Calcualte(),
                      Category: bmi.bmiCategory(),
                      description: bmi.bmiDescription(),
                    );
                  },
                ),
              );
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
                    child: const Text(
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
