import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.quadraticBezierTo(
         size.width, size.height - 100,size.width / 3, size.height,);
    path.lineTo(0, size.height - 120);
    path.quadraticBezierTo(
        size.width / 3, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
