import 'package:busbooking/controllers/sign_in_controller.dart';
import 'package:busbooking/helpers/datetime_helper.dart';
import 'package:busbooking/utils/colors.dart';
import 'package:busbooking/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/ticket_details_controller.dart';

class ViewTicketWidget extends StatefulWidget {
  ViewTicketWidget({
    super.key,
    this.ticketID,
    this.origincity,
    this.destinationcity,
    this.departuretime,
    this.arrivaltime,
    this.name,
    this.traveldate,
    this.originterminal,
    this.totalseat,
    this.amount,
  });

  String? ticketID;
  String? origincity;
  String? destinationcity;
  String? departuretime;
  String? arrivaltime;
  String? name;
  String? traveldate;
  String? originterminal;
  String? totalseat;
  String? amount;

  @override
  State<ViewTicketWidget> createState() => _ViewTicketWidgetState();
}

class _ViewTicketWidgetState extends State<ViewTicketWidget> {
  TicketDetailsController ticketDetailsController = Get.put(
    TicketDetailsController(),
  );

  @override
  void initState() {
    super.initState();
    ticketDetailsController.fetchticketDetails(widget.ticketID.toString());
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Obx(
            () => ticketDetailsController.isLoading.value == false
                ? ListView(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 10,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 8,
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            child: KText(
                              text: languagesController.tr("ISSUED_TITLE"),
                              fontSize: 12,
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      TicketWidget(
                        width: 340,
                        height: 450,
                        cutoutRadius: 15,
                        cornerRadius: 10, // 👈 controls top & bottom rounding
                        topSectionColor: Colors.white,
                        middleSectionColor: Colors.white,
                        bottomSectionColor: Colors.white,
                        // Content for each section – stays inside its own area
                        topChild: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Column(
                                    spacing: 4,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      KText(
                                        text: languagesController.tr("ORIGIN"),
                                        color: AppColors.defaultFontColor,
                                        fontSize: 13,
                                      ),
                                      KText(
                                        text: ticketDetailsController
                                            .ticketdetails
                                            .value
                                            .body!
                                            .item!
                                            .trip!
                                            .route!
                                            .originCity!
                                            .name
                                            .toString(),
                                        fontSize: 13,
                                      ),
                                      KText(
                                        text: convertToLocalTime(
                                          ticketDetailsController
                                              .ticketdetails
                                              .value
                                              .body!
                                              .item!
                                              .trip!
                                              .departureTime!
                                              .toString(),
                                        ),
                                        fontSize: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/goingicon.png",
                                      height: 18,
                                    ),
                                    KText(
                                      text: getDistanceTime(
                                        ticketDetailsController
                                            .ticketdetails
                                            .value
                                            .body!
                                            .item!
                                            .trip!
                                            .departureTime!
                                            .toString(),
                                        ticketDetailsController
                                            .ticketdetails
                                            .value
                                            .body!
                                            .item!
                                            .trip!
                                            .arrivalTime!
                                            .toString(),
                                      ),
                                      fontSize: 8,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Column(
                                    spacing: 4,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      KText(
                                        text: languagesController.tr(
                                          "DESTINATION",
                                        ),
                                        color: AppColors.defaultFontColor,
                                        fontSize: 13,
                                      ),
                                      KText(
                                        text: ticketDetailsController
                                            .ticketdetails
                                            .value
                                            .body!
                                            .item!
                                            .trip!
                                            .route!
                                            .destinationCity!
                                            .name
                                            .toString(),
                                        fontSize: 13,
                                      ),
                                      KText(
                                        text: convertToLocalTime(
                                          ticketDetailsController
                                              .ticketdetails
                                              .value
                                              .body!
                                              .item!
                                              .trip!
                                              .arrivalTime!
                                              .toString(),
                                        ),
                                        fontSize: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        middleChild: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Container(
                            // color: Colors.red,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 8),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            // color: Colors.lightBlue,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  KText(
                                                    text: languagesController
                                                        .tr("FULL_NAME"),
                                                    color: AppColors
                                                        .defaultFontColor,
                                                    fontSize: 12,
                                                  ),
                                                  SizedBox(height: 5),
                                                  KText(
                                                    textAlign: TextAlign.center,
                                                    text:
                                                        ticketDetailsController
                                                            .ticketdetails
                                                            .value
                                                            .body!
                                                            .item!
                                                            .user!
                                                            .firstName
                                                            .toString() +
                                                        " " +
                                                        ticketDetailsController
                                                            .ticketdetails
                                                            .value
                                                            .body!
                                                            .item!
                                                            .user!
                                                            .lastName
                                                            .toString(),
                                                    fontSize: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            // color: Colors.cyan,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,

                                              children: [
                                                KText(
                                                  text: languagesController.tr(
                                                    "MOVE_DATE",
                                                  ),
                                                  color: AppColors
                                                      .defaultFontColor,
                                                  fontSize: 12,
                                                ),
                                                SizedBox(height: 5),
                                                KText(
                                                  textAlign: TextAlign.center,
                                                  text: convertToDate(
                                                    ticketDetailsController
                                                        .ticketdetails
                                                        .value
                                                        .body!
                                                        .item!
                                                        .trip!
                                                        .departureTime
                                                        .toString(),
                                                  ),
                                                  fontSize: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            // color: Colors.red,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: languagesController.tr(
                                                    "TOTAL_SEAT",
                                                  ),
                                                  color: AppColors
                                                      .defaultFontColor,
                                                  fontSize: 12,
                                                ),
                                                SizedBox(height: 5),
                                                KText(
                                                  text: ticketDetailsController
                                                      .ticketdetails
                                                      .value
                                                      .body!
                                                      .item!
                                                      .tickets!
                                                      .length
                                                      .toString(),
                                                  fontSize: 12,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 8),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: languagesController.tr(
                                                  "IDENTIFICATION_NUMBER",
                                                ),
                                                color:
                                                    AppColors.defaultFontColor,
                                                fontSize: 10,
                                              ),
                                              SizedBox(height: 5),
                                              KText(text: "----", fontSize: 12),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: languagesController.tr(
                                                  "DEPARTURE_TIME",
                                                ),
                                                color:
                                                    AppColors.defaultFontColor,
                                                fontSize: 12,
                                              ),
                                              SizedBox(height: 5),
                                              KText(
                                                text: convertToLocalTime(
                                                  ticketDetailsController
                                                      .ticketdetails
                                                      .value
                                                      .body!
                                                      .item!
                                                      .trip!
                                                      .departureTime
                                                      .toString(),
                                                ),
                                                fontSize: 10,
                                              ),
                                            ],
                                          ),
                                        ),

                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: languagesController.tr(
                                                  "AMOUNT",
                                                ),
                                                color:
                                                    AppColors.defaultFontColor,
                                                fontSize: 12,
                                              ),
                                              SizedBox(height: 5),
                                              KText(
                                                text: ticketDetailsController
                                                    .ticketdetails
                                                    .value
                                                    .body!
                                                    .item!
                                                    .totalPrice
                                                    .toString(),
                                                fontSize: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Expanded(flex: 1, child: Container()),

                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            // color: Colors.green,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  KText(
                                                    textAlign: TextAlign.center,
                                                    text: languagesController
                                                        .tr("ORIGIN_TERMINAL"),
                                                    color: AppColors
                                                        .defaultFontColor,
                                                    fontSize: 10,
                                                  ),
                                                  SizedBox(height: 5),
                                                  KText(
                                                    text:
                                                        ticketDetailsController
                                                            .ticketdetails
                                                            .value
                                                            .body!
                                                            .item!
                                                            .trip!
                                                            .route!
                                                            .originStation!
                                                            .name
                                                            .toString(),
                                                    fontSize: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            // color: Colors.orange,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  KText(
                                                    text: languagesController
                                                        .tr("SEAT"),
                                                    color: AppColors
                                                        .defaultFontColor,
                                                    fontSize: 12,
                                                  ),
                                                  SizedBox(height: 5),
                                                  KText(
                                                    text: "A3",
                                                    fontSize: 12,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        bottomChild: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(
                                        "https://milliekit.vercel.app/assets/images/tmp/sample-barcode.png",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: KText(
                                  textAlign: TextAlign.center,
                                  text: languagesController.tr(
                                    "SHOW_THIS_BARCODE",
                                  ),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Dashed lines at the cutout centers
                        dashPositions: [0.3, 0.7],
                        dashColor: Colors.white,
                        dashWidth: 2,
                        dashSpace: 2,
                        strokeWidth: 1,
                      ),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                            top: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 50,
                                width: double.maxFinite,
                                // color: Colors.red,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () async {
                                          // capturePng(_captureKey);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: Color(0xff2196F3),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Center(
                                            child: KText(
                                              text: languagesController.tr(
                                                "SAVE_TO_GALLERY",
                                              ),
                                              fontSize: 12,
                                              color: Color(0xff2196F3),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () async {
                                          // captureImageFromWidgetAsFile(shareKey);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xff2196F3),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Center(
                                            child: KText(
                                              text: languagesController.tr(
                                                "SHARE",
                                              ),
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: KText(
                                      text: languagesController.tr("CLOSE"),
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator(color: Colors.grey)),
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
class TicketWidget extends StatelessWidget {
  final double width;
  final double height;
  final double cutoutRadius;
  final double cornerRadius; // 👈 new parameter for top/bottom rounding
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;

  // Three section colors
  final Color topSectionColor;
  final Color middleSectionColor;
  final Color bottomSectionColor;

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

  TicketWidget({
    super.key,
    required this.width,
    required this.height,
    this.cutoutRadius = 20.0,
    this.cornerRadius = 15.0, // default
    this.border,
    this.boxShadow,
    required this.topSectionColor,
    required this.middleSectionColor,
    required this.bottomSectionColor,
    this.topChild,
    this.middleChild,
    this.bottomChild,
    this.dashPositions,
    this.dashColor = Colors.black,
    this.dashWidth = 6,
    this.dashSpace = 4,
    this.strokeWidth = 1.5,
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
                // Top section – rounded top corners
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: topSectionColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(cornerRadius),
                        topRight: Radius.circular(cornerRadius),
                      ),
                    ),
                    child: topChild ?? SizedBox.shrink(),
                  ),
                ),
                // Middle section – no rounding
                Expanded(
                  flex: 5,
                  child: Container(
                    color: middleSectionColor,
                    child: middleChild ?? SizedBox.shrink(),
                  ),
                ),
                // Bottom section – rounded bottom corners
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: bottomSectionColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(cornerRadius),
                        bottomRight: Radius.circular(cornerRadius),
                      ),
                    ),
                    child: bottomChild ?? SizedBox.shrink(),
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
                    color: Colors.grey,
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
