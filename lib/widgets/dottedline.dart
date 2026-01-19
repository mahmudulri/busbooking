import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final double width;

  const DottedLine({super.key, this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(width, 1), painter: _DottedLinePainter());
  }
}

class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    const dashWidth = 6;
    const dashSpace = 4;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
