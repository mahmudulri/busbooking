library ticket_widget;

import 'package:flutter/material.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.child,
    this.padding,
    this.margin,
    this.decoration,
    this.cutOffset = 40,
    this.cutRadius = 20,
  }) : super(key: key);

  final double width;
  final double height;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  /// Fully customizable decoration
  final BoxDecoration? decoration;

  /// Ticket cut controls
  final double cutOffset;
  final double cutRadius;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(cutOffset: cutOffset, cutRadius: cutRadius),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: decoration,
        child: child,
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  final double cutOffset;
  final double cutRadius;

  TicketClipper({required this.cutOffset, required this.cutRadius});

  @override
  Path getClip(Size size) {
    final Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0);

    final double cutPosition = size.height / 2 + 40;

    path.addOval(
      Rect.fromCircle(center: Offset(0, cutPosition), radius: cutRadius),
    );

    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width, cutPosition),
        radius: cutRadius,
      ),
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
