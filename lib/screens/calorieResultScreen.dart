import 'package:flutter/material.dart';

class CalorieResultScreen extends StatelessWidget {
  final maintianCalories;
  CalorieResultScreen({@required this.maintianCalories});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    'Your Result',
                    style: TextStyle(
                      fontSize: width * 0.1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Card(
                shape: CircleBorder(),
                elevation: 20,
                child: Container(
                  //padding: EdgeInsets.all(15.0),
                  //margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        color: Theme.of(context).accentColor,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          maintianCalories + ' cal/day to maintain your weight',
                          style: TextStyle(
                              color: Colors.white, fontSize: width * 0.04),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Theme.of(context).accentColor,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          (double.parse(maintianCalories) - 500).toString() +
                              ' cal/day to lose 0.5kg per weak',
                          style: TextStyle(
                              color: Colors.white, fontSize: width * 0.04),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Theme.of(context).accentColor,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          (double.parse(maintianCalories) - 1000).toString() +
                              ' cal/day to lose 1kg per weak',
                          style: TextStyle(
                              color: Colors.white, fontSize: width * 0.04),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Theme.of(context).accentColor,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          (double.parse(maintianCalories) + 500).toString() +
                              ' cal/day to gain 0.5kg per weak',
                          style: TextStyle(
                              color: Colors.white, fontSize: width * 0.04),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Theme.of(context).accentColor,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          (double.parse(maintianCalories) + 1000).toString() +
                              ' cal/day to gain 1kg per weak',
                          style: TextStyle(
                              color: Colors.white, fontSize: width * 0.04),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
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
                          child: Text('Re-Calculate',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ],
                ),
              ),
            )
            // Reusablebutton(
            //      textbutton: 'RE-CALCULATE',
            //      onpress: () {
            //        Navigator.pop(context);
            //      }),
          ],
        ),
      ),
    );
  }
}
