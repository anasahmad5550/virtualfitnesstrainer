import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, @required this.onpress});
  final IconData icon;
  final Function onpress;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        icon,
        color: Colors.white,
      ),
      shape: CircleBorder(),
      onPressed: onpress,
      highlightColor: Colors.white,
      fillColor: Theme.of(context).accentColor,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top) *
            0.07,
        width: 56.0,
      ),
    );
  }
}
