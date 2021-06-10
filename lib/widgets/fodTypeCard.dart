import 'package:flutter/material.dart';

class FoodTypeCard extends StatelessWidget {
  const FoodTypeCard({this.image, this.title, this.isSelected, this.onPress});

  final String image;
  final String title;
  final bool isSelected;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: FittedBox(
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF83D6C1) : Colors.grey[200],
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                right: 10.0,
                top: 10.0,
                child: isSelected
                    ? Icon(
                        Icons.check_circle_outline,
                        color: Colors.black.withOpacity(0.2),
                      )
                    : SizedBox.shrink(),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image(
                      image: AssetImage(
                        image,
                      ),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.blueGrey[800]
                            : Colors.grey[500],
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
