import 'dart:math';
import 'package:flutter/cupertino.dart';

class Calculatebmi {
  Calculatebmi({@required this.height, @required this.wight});
  final int height;
  final int wight;

  double _bmi;

  String Calcualte() {
    _bmi = wight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String bmiCategory() {
    if (_bmi > 30.0) {
      return 'OBESE RANGE';
    } else if (_bmi > 25.0) {
      return 'OVER-WEIGHT';
    } else if (_bmi > 18.5) {
      return 'NORMAL WEIGHT';
    } else
      return 'UNDERWEIGHT';
  }

  String bmiDescription() {
    if (_bmi > 30.0) {
      return 'You have a very heavy weight, Try to exercise more and more';
    } else if (_bmi > 25.0) {
      return 'You have a higher than a normal body weight, Try to exercise more';
    } else if (_bmi > 18.5) {
      return 'You have a normal body weight. Good Job';
    } else
      return 'You have a lower than a normal body weight. You can eat a bit more';
  }
}
