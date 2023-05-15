import 'package:flutter/cupertino.dart';

class Units {
  static double width(context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(context) {
    return MediaQuery.of(context).size.height;
  }

  static double heading(context) {
    return MediaQuery.of(context).size.height * 0.03;
  }

  static double title(context) {
    return MediaQuery.of(context).size.height * 0.035;
  }

  static double content(context) {
    return MediaQuery.of(context).size.height * 0.018;
  }

  static double regularText(context) {
    return MediaQuery.of(context).size.height * 0.025;
  }
}
