import 'package:busbooking/widgets/custom_text.dart';
import 'package:busbooking/widgets/default_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../draft.dart';
import '../globalcontroller/languages_controller.dart';
import '../globalcontroller/page_controller.dart';
import 'bus_search_result_screen.dart';

class BusReserveScreen extends StatefulWidget {
  BusReserveScreen({super.key});

  @override
  State<BusReserveScreen> createState() => _BusReserveScreenState();
}

class _BusReserveScreenState extends State<BusReserveScreen> {
  final mypagecontroller = Get.find<Mypagecontroller>();

  final languagesController = Get.find<LanguagesController>();

  TextEditingController fromController = TextEditingController();

  String origin = "Fayzabad";
  String destination = "Jur";

  void swapLocation() {
    setState(() {
      final temp = origin;
      origin = destination;
      destination = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,

      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        mypagecontroller.goBack();
      },

      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // keep transparent
          statusBarIconBrightness: Brightness.light, // Android icons
        ),

        child: Scaffold(
          body: Container(
            height: screenHeight,
            width: screenWidth,

            child: Stack(
              children: [
                Container(
                  height: 250,
                  width: screenWidth,

                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/buspageheader.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Colors.white,
                                ),
                              ),
                              KText(
                                text: "رزرو اتوبوس",
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.menu, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 180,
                  child: Container(
                    height: screenHeight,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 15,
                  right: 15,
                  top: 100,
                  child: Container(
                    height: screenHeight,
                    width: screenWidth,
                    // color: Colors.red,
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      children: [
                        Container(
                          height: 250,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 4,
                                offset: Offset(4, 4),
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 4,
                                offset: Offset(-4, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                // DottedBorder(
                                //   options: RoundedRectDottedBorderOptions(
                                //     radius: Radius.circular(
                                //       12,
                                //     ), // 👈 border radius
                                //     color: Colors.red, // 👈 border color
                                //     strokeWidth: 2, // optional
                                //     dashPattern: [
                                //       6,
                                //       3,
                                //     ], // optional: dot/space pattern
                                //   ),
                                //   child: Container(
                                //     height: 50,
                                //     width: 200,
                                //     alignment: Alignment.center,
                                //     child: Text('Dotted Border'),
                                //   ),
                                // ),
                                Container(
                                  // color: Colors.red,
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      Column(
                                        children: [
                                          selectionCard(
                                            type: languagesController.tr(
                                              "ORIGIN",
                                            ),
                                            title: "Exit",
                                            value: destination,

                                            controller: fromController,
                                          ),
                                          SizedBox(height: 5),
                                          selectionCard(
                                            type: languagesController.tr(
                                              "DESTINATION",
                                            ),
                                            title: "Enter",
                                            value: origin,

                                            controller: fromController,
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        right: 8,
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.swap_vert,
                                              color: Colors.grey,
                                            ),
                                            onPressed: swapLocation,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                DefaultButton(
                                  onTap: () {
                                    // Get.to(() => BusTrip());
                                    mypagecontroller.changePage(
                                      BusSearchResultScreen(),
                                      isMainPage: false,
                                    );
                                  },
                                  child: Center(
                                    child: KText(
                                      text: languagesController.tr(
                                        "SEARCH_BUS",
                                      ),
                                      color: Colors.white,
                                      fontSize: screenHeight * 0.020,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget selectionCard({
  required String title,
  required String type,
  required String value,
  required TextEditingController controller,
}) {
  return Container(
    height: 60,
    decoration: BoxDecoration(
      color: Color(0xFFF9FAFB),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(width: 1, color: Color(0xFFE5E7EB)),
      boxShadow: [
        BoxShadow(
          color: Color(0x33919EAB),
          offset: Offset(0, 0),
          blurRadius: 2,
          spreadRadius: 0,
        ),
      ],
    ),

    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/icons/car.png", height: 23),
                SizedBox(width: 3),
                KText(
                  text: type.toString(),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff161C24),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          VerticalDivider(
            width: 2,
            color: Colors.grey.shade500,
            endIndent: 10,
            indent: 10,
          ),
          SizedBox(width: 8),

          Expanded(
            flex: 5,
            child: Container(
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
