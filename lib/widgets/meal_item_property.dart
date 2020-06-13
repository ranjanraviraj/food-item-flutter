import 'package:flutter/material.dart';

class MealItemProperty extends StatelessWidget {
  const MealItemProperty({
    Key key,
    @required this.displayText,
    @required this.icon
  }) : super(key: key);

  final String displayText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(
          width: 6,
        ),
        Text(displayText),
      ],
    );
  }
}