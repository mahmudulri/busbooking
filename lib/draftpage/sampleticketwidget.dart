import 'package:flutter/material.dart';

class TicketDemoScreen extends StatelessWidget {
  TicketDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Widget Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TicketWidget(
                  width: 340,
                  height: 550,
                  cutoutRadius: 15,
                  cornerRadius: 10,
                  topSectionColor: Colors.purple,
                  middleSectionColor: Colors.red,
                  bottomSectionColor: Colors.yellow,

                  // Individual shadows for each section
                  topBoxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                  middleBoxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                  bottomBoxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],

                  // Content for each section
                  topChild: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '🎸 ROCK FESTIVAL',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Main Stage',
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '15 JUN 2024',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  middleChild: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'SECTION A',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          'ROW 5 • SEAT 12',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  bottomChild: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'PRICE',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              '\$49.99',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.qr_code, size: 40, color: Colors.black87),
                      ],
                    ),
                  ),
                  // Dashed lines
                  dashPositions: [0.3, 0.7],
                  dashColor: Colors.white,
                  dashWidth: 8,
                  dashSpace: 6,
                  strokeWidth: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Ticket clipper with four side cutouts (two left, two right).
class TicketClipper extends CustomClipper<Path> {
  final double cutoutRadius;

  TicketClipper({this.cutoutRadius = 20.0});

  @override
  Path getClip(Size size) {
    final double w = size.width;
    final double h = size.height;
    final double r = cutoutRadius;

    // Cutout centers at 30% and 70% of height
    final double topCutY = h * 0.3;
    final double bottomCutY = h * 0.7;

    final path = Path()..addRect(Rect.fromLTWH(0, 0, w, h));

    // Left cutouts
    final leftTop = Path()
      ..addOval(Rect.fromCircle(center: Offset(0, topCutY), radius: r));
    final leftBottom = Path()
      ..addOval(Rect.fromCircle(center: Offset(0, bottomCutY), radius: r));

    // Right cutouts
    final rightTop = Path()
      ..addOval(Rect.fromCircle(center: Offset(w, topCutY), radius: r));
    final rightBottom = Path()
      ..addOval(Rect.fromCircle(center: Offset(w, bottomCutY), radius: r));

    final afterLeftTop = Path.combine(PathOperation.difference, path, leftTop);
    final afterLeftBottom = Path.combine(
      PathOperation.difference,
      afterLeftTop,
      leftBottom,
    );
    final afterRightTop = Path.combine(
      PathOperation.difference,
      afterLeftBottom,
      rightTop,
    );
    return Path.combine(PathOperation.difference, afterRightTop, rightBottom);
  }

  @override
  bool shouldReclip(covariant TicketClipper oldClipper) =>
      oldClipper.cutoutRadius != cutoutRadius;
}

/// Ticket widget with three independent content sections and rounded top/bottom corners.
/// Now each section can have its own box shadow.
class TicketWidget extends StatelessWidget {
  final double width;
  final double height;
  final double cutoutRadius;
  final double cornerRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow; // outer shadow for the whole ticket

  // Three section colors
  final Color topSectionColor;
  final Color middleSectionColor;
  final Color bottomSectionColor;

  // Individual shadows for each section
  final List<BoxShadow>? topBoxShadow;
  final List<BoxShadow>? middleBoxShadow;
  final List<BoxShadow>? bottomBoxShadow;

  // Content for each section (optional)
  final Widget? topChild;
  final Widget? middleChild;
  final Widget? bottomChild;

  // Dashed line properties
  final List<double>? dashPositions;
  final Color dashColor;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;

  const TicketWidget({
    super.key,
    required this.width,
    required this.height,
    this.cutoutRadius = 20.0,
    this.cornerRadius = 15.0,
    this.border,
    this.boxShadow,
    required this.topSectionColor,
    required this.middleSectionColor,
    required this.bottomSectionColor,
    this.topChild,
    this.middleChild,
    this.bottomChild,
    this.dashPositions,
    this.dashColor = Colors.grey,
    this.dashWidth = 6,
    this.dashSpace = 4,
    this.strokeWidth = 1.5,
    // new shadow parameters
    this.topBoxShadow,
    this.middleBoxShadow,
    this.bottomBoxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(cutoutRadius: cutoutRadius),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(border: border, boxShadow: boxShadow),
        child: Stack(
          children: [
            // Colored sections with their own content
            Column(
              children: [
                // Top section – rounded top corners + its own shadow
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: topSectionColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(cornerRadius),
                        topRight: Radius.circular(cornerRadius),
                      ),
                      boxShadow: topBoxShadow,
                    ),
                    child: topChild ?? const SizedBox.shrink(),
                  ),
                ),
                // Middle section – no rounding + its own shadow
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: middleSectionColor,
                      boxShadow: middleBoxShadow,
                    ),
                    child: middleChild ?? const SizedBox.shrink(),
                  ),
                ),
                // Bottom section – rounded bottom corners + its own shadow
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: bottomSectionColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(cornerRadius),
                        bottomRight: Radius.circular(cornerRadius),
                      ),
                      boxShadow: bottomBoxShadow,
                    ),
                    child: bottomChild ?? const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
            // Dashed lines overlay
            if (dashPositions != null)
              Positioned.fill(
                child: CustomPaint(
                  painter: _DashedLinePainter(
                    yFractions: dashPositions!,
                    dashWidth: dashWidth,
                    dashSpace: dashSpace,
                    color: dashColor,
                    strokeWidth: strokeWidth,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Paints dashed lines at given fractional y positions.
class _DashedLinePainter extends CustomPainter {
  final List<double> yFractions;
  final double dashWidth;
  final double dashSpace;
  final Color color;
  final double strokeWidth;

  _DashedLinePainter({
    required this.yFractions,
    required this.dashWidth,
    required this.dashSpace,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    for (double fraction in yFractions) {
      double y = size.height * fraction;
      double x = 0.0;
      while (x < size.width) {
        double endX = (x + dashWidth).clamp(0, size.width);
        canvas.drawLine(Offset(x, y), Offset(endX, y), paint);
        x += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) {
    return oldDelegate.yFractions != yFractions ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
