import 'package:flutter/material.dart';

BoxDecoration buildBoxDecoration(Color color) {
  return BoxDecoration(
    color: Colors.black.withOpacity(0.5),
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
          color: color,
          blurRadius: 20.0,
          offset: const Offset(5.0, 5.0),
          blurStyle: BlurStyle.inner),
    ],
  );
}

BoxDecoration buildBoxDecoration2() {
  return BoxDecoration(
    color: Colors.black.withOpacity(0.5),
    borderRadius: BorderRadius.circular(15),
    gradient: const LinearGradient(
      colors: [
        Colors.pink,
        Colors.blue,
      ],
    ),
  );
}

BoxDecoration buildBoxDecoration3() {
  return BoxDecoration(
    //color: Colors.pink.shade600.withOpacity(0.3),
    borderRadius: BorderRadius.circular(30),
    gradient: LinearGradient(
      colors: [
        Colors.pink.shade900.withOpacity(0.9),
        Colors.pink.shade600.withOpacity(0.1),
      ],
    ),
  );
}

BoxDecoration buildBoxDecoration4() {
  return BoxDecoration(
    //color: Colors.blue.shade300.withOpacity(0.3),
    borderRadius: BorderRadius.circular(30),
    gradient: LinearGradient(
      colors: [
        Colors.blue.shade900.withOpacity(0.1),
        Colors.blue.shade600.withOpacity(0.9),
      ],
    ),
  );
}
