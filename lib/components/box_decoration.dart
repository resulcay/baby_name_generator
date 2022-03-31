import 'package:flutter/material.dart';

BoxDecoration buildBoxDecoration() {
  return BoxDecoration(
      borderRadius: const BorderRadius.only(
        topRight: Radius.elliptical(0.0, 0.0),
        topLeft: Radius.elliptical(50.0, 50.0),
        bottomRight: Radius.elliptical(50.0, 50.0),
        bottomLeft: Radius.elliptical(50.0, 50.0),
      ),
      gradient: LinearGradient(colors: [
        Colors.pink.shade300,
        Colors.blue.shade300,
      ]));
}
