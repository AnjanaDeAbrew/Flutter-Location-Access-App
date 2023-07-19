import 'package:flutter/material.dart';

class Utilfunctions {
  //----------navigator function
  static navigateTo(BuildContext context, Widget widget) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  }

//----------navigator function go back
  static goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
