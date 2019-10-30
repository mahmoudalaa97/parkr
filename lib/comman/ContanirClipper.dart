import 'package:flutter/material.dart';

class ContainerClipper extends CustomClipper<Path> {
  ContainerClipper({this.borderRadius = 15});
  final double borderRadius;
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    double rheight = height - height / 3;
    double oneThird = width / 3;

    final path = Path()
      ..lineTo(0, rheight)
      ..cubicTo(0, rheight , 0, rheight, 0, rheight)
      ..lineTo(oneThird, rheight)
      ..lineTo(width/2-borderRadius, height-borderRadius)
      ..cubicTo(width / 2 - borderRadius, height - borderRadius, width / 2,
          height, width / 2 + borderRadius, height - borderRadius )
      ..lineTo(2 * oneThird, rheight)
      ..lineTo(width-borderRadius, rheight)
      ..cubicTo(width - borderRadius, rheight, width, rheight, width,
          rheight - borderRadius)
      ..lineTo(width, 0)
      ..lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
