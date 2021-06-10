import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtualfitnesstrainer/widgets/fodTypeCard.dart';
import 'MealsScreen.dart';

class DietPlanscreen extends StatefulWidget {
  DietPlanscreen({Key key}) : super(key: key);

  @override
  _DietPlanscreen createState() => _DietPlanscreen();
}

class _DietPlanscreen extends State<DietPlanscreen> {
  List<String> meals = ['1 meal', '2 meals', '3 meals', '4 meals'];
  String selected = '4 meals';

  bool _isAnythingSelected = false;
  bool _isvegSelected = false;
  bool _isMedSelected = false;
  bool _isPaleoSelected = false;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("users")
          .doc(_auth.currentUser.uid)
          .get(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              //backgroundColor: Colors.white,
              appBar: AppBar(
                //brightness: Brightness.light,
                elevation: 0.0,
                //backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 22.0,
                            backgroundColor: Colors.transparent,
                            backgroundImage: snapshot.data['image_url'] != null
                                ? NetworkImage(snapshot.data['image_url'])
                                : null,
                            child: FittedBox(
                              child: snapshot.data['image_url'] == null
                                  ? Icon(
                                      Icons.person,
                                      color: Colors.grey[600],
                                      size: 200,
                                    )
                                  : null,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            snapshot.data['name'] != null
                                ? 'Hi ${snapshot.data['name']}'
                                : 'No Name',
                            style: TextStyle(
                              //color: Colors.blueGrey[800],
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(
                    //     Icons.search,
                    //     color: Colors.blueGrey[800],
                    //     size: 25.0,
                    //   ),
                    // )
                  ],
                ),
              ),
              body: Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                  left: 30.0,
                  right: 30.0,
                  bottom: 20.0,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Let us know your diet.',
                          style: TextStyle(
                            color: Colors.blueGrey[800],
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 340.0,
                          child: GridView(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            children: <Widget>[
                              FoodTypeCard(
                                image: 'images/Bfast.png',
                                title: 'BreakFast',
                                isSelected: _isAnythingSelected,
                                onPress: () {
                                  setState(() {
                                    _isAnythingSelected = !_isAnythingSelected;
                                  });
                                },
                              ),
                              FoodTypeCard(
                                image: 'images/desi.jpg',
                                title: 'Lunch',
                                isSelected: _isvegSelected,
                                onPress: () {
                                  setState(() {
                                    _isvegSelected = !_isvegSelected;
                                  });
                                },
                              ),
                              FoodTypeCard(
                                image: 'images/abc.jpg',
                                title: 'Dinner',
                                isSelected: _isMedSelected,
                                onPress: () {
                                  setState(() {
                                    _isMedSelected = !_isMedSelected;
                                  });
                                },
                              ),
                              FoodTypeCard(
                                image: 'images/def.jpg',
                                title: 'Snacks',
                                isSelected: _isPaleoSelected,
                                onPress: () {
                                  setState(() {
                                    _isPaleoSelected = !_isPaleoSelected;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'I want to eat',
                              style: TextStyle(
                                color: Colors.blueGrey[800],
                                fontSize: 19.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 0.0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: '1500 Calories',
                                hintStyle: TextStyle(
                                  //color: Colors.grey[500],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                                suffixText: 'Not sure?',
                                suffixStyle: TextStyle(
                                  color: Color(0xFF83D6C1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'in how many meals?',
                              style: TextStyle(
                                color: Colors.blueGrey[800],
                                fontSize: 19.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 4.0,
                                ),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  underline: SizedBox.shrink(),
                                  value: selected,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      selected = value;
                                    });
                                  },
                                  items: meals.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                elevation: 0.0,
                child: Padding(
                  padding:
                      EdgeInsets.only(right: 30.0, left: 30.0, bottom: 20.0),
                  child: FlatButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ListViewHomePage(),
                        ),
                      );
                    },
                    child: Text(
                      'Generate',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
