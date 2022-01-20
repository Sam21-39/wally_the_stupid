import 'package:flutter/material.dart';

class UI {
  // colors
  static final appBackColor = Color(0xff8BAFC3);
  static final appButtonColor = Color(0xff11948C);
  static final appBackDarkColor = Color(0xff243844);

  //textstyles
  static final appText = TextStyle(
    color: Colors.white,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w700,
    fontSize: 18.0,
    shadows: [
      Shadow(
        color: Colors.black.withOpacity(0.75),
      ),
    ],
  );
}
