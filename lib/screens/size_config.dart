import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

class SizeConfig {
  static double _screenWidth;
  static double _screenHeight;
  static double _blockSizeHorizontal = 0;
  static double _blockSizeVertical = 0;

  static double textMultiplier;
  static double imageSizeMultiplier;
  static double heightMultiplier;

  void init(BoxConstraints constraints) {
    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.minHeight;

    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;

    textMultiplier = _blockSizeVertical;
    imageSizeMultiplier = _blockSizeHorizontal;
    heightMultiplier = _blockSizeVertical;

    // print("vertical:  " + _blockSizeVertical.toString());
    // print("horizontal:  " + _blockSizeHorizontal.toString());
  }
}
