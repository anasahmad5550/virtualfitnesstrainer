import 'package:flutter/material.dart';

class MealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListViewHomePage(),
    );
  }
}

class ListViewHomePage extends StatefulWidget {
  @override
  _ListViewHomePageState createState() => _ListViewHomePageState();
}

class _ListViewHomePageState extends State<ListViewHomePage> {
  var titleList = ["Beans", "Bacon&Eggs", "Yogurt", "Pancakes"];

  var descList = [
    "Beans on toast are a classic for breakfast or lunch, now you know you can enjoy it without worrying about the calories too much. Plus it has nearly 12g of fibre!",
    "Made with extra eggs and part wholemeal flour, our pimped-up pancakes are higher in both protein and fibre - to keep you fuller for longer. Try them topped with fresh raspberries and a drizzle of chocolate sauce ",
    "Everybody loves a fry up, try this low calorie, simple fry up on toast! Cook the eggs any way you like, just remember to change your food diary. Try adding a tablespoon of fresh salsa rather than tomato sauce for a tangy twist.",
    "Try it"
  ];

  var imgList = [
    "images/image.jpg",
    "images/image1.jpg",
    "images/image2.jpg",
    "images/image3.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(29, 14, 54, 1),
        title: Text(
          "Your diet plan is ready!",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
          itemCount: imgList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Card(
                color: Theme.of(context).canvasColor,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.asset(imgList[index]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            titleList[index],
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: width,
                            child: Text(
                              descList[index],
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
