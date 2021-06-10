import 'package:flutter/material.dart';

import 'package:virtualfitnesstrainer/constants.dart';

class BmiResult extends StatelessWidget {
  BmiResult(
      {@required this.result,
      @required this.Category,
      @required this.description});
  final String result;
  final String Category;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: const Text(
                    'Your Result',
                    style: kresult,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        Category,
                        style: kresultcategory,
                      ),
                      Text(
                        result,
                        style: kanswer,
                      ),
                      Text(
                        description,
                        style: kdescription,
                        textAlign: TextAlign.center,
                      )
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
                          child: const Text('Re-Calculate',
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
