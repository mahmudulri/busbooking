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
import '../widgets/dottedline.dart';
import 'draftseatscreen.dart';

class BusSearchResultScreen extends StatefulWidget {
  BusSearchResultScreen({super.key});

  @override
  State<BusSearchResultScreen> createState() => _BusSearchResultScreenState();
}

class _BusSearchResultScreenState extends State<BusSearchResultScreen> {
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
                                text: "بلیط اتوبوس تالقان به هرات",
                                color: Colors.white,
                                fontSize: 20,
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
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 18,
                        right: 18,
                        top: 18,
                        bottom: 300,
                      ),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(0.0),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => Draftseatscreen());
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8),
                              height: 250,
                              width: screenWidth,
                              color: Colors.transparent,
                              child: Container(
                                height: 250,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 250,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xFFE5E7EB),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x33919EAB),
                                            offset: Offset(0, 0),
                                            blurRadius: 2,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: Row(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 20,
                                                            backgroundColor:
                                                                Colors.teal,
                                                          ),
                                                          SizedBox(width: 5),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,

                                                            children: [
                                                              KText(
                                                                text:
                                                                    "Bus Company",
                                                                fontSize: 12,
                                                              ),
                                                              KText(
                                                                text:
                                                                    "Etihad Bus Company",
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,

                                                            children: [
                                                              KText(
                                                                text:
                                                                    "1 Adult, 2 Children",
                                                                fontSize: 12,
                                                              ),
                                                              KText(
                                                                text:
                                                                    "Bus Model",
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                KText(
                                                                  text:
                                                                      "Taleqan",
                                                                  fontSize: 12,
                                                                ),
                                                                KText(
                                                                  text: "02:00",
                                                                  fontSize: 12,
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                          Expanded(
                                                            flex: 1,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/goingicon.png",
                                                                  height: 20,
                                                                ),
                                                                KText(
                                                                  text:
                                                                      "3 h 14m",
                                                                  fontSize: 10,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Container(
                                                              // color: Colors.red,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  KText(
                                                                    text:
                                                                        "Mazandaran Sharif",
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                  KText(
                                                                    text:
                                                                        "24:00",
                                                                    fontSize:
                                                                        12,
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
                                                    flex: 1,
                                                    child: Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              KText(
                                                                text: "From",
                                                                fontSize: 12,
                                                              ),
                                                              KText(
                                                                text: "Taleqan",
                                                                fontSize: 12,
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              KText(
                                                                text: "To",
                                                                fontSize: 12,
                                                              ),
                                                              KText(
                                                                text:
                                                                    "Mazandaran Sharif",
                                                                fontSize: 12,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            DottedLine(),

                                            Container(
                                              height: 70,
                                              width: screenWidth,
                                              // color: Colors.cyan,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Image.asset(
                                                              "assets/icons/ticket.png",
                                                              height: 20,
                                                            ),
                                                            SizedBox(width: 8),
                                                            KText(
                                                              text:
                                                                  "7 Seats Available",
                                                              fontSize: 13,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          KText(
                                                            text:
                                                                "Total Price : ",
                                                            fontSize: 13,
                                                          ),
                                                          KText(
                                                            text: "1000 Afn",
                                                            fontSize: 13,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // ...............................Main Box......................//
                                    Positioned(
                                      left: -25,
                                      top: 90,
                                      bottom: 0,
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 1,
                                            color: Color(0xFFE5E7EB),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x33919EAB),
                                              offset: Offset(0, 0),
                                              blurRadius: 2,
                                              spreadRadius: 0,
                                            ),
                                          ],
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: -25,
                                      top: 90,
                                      bottom: 0,
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 1,
                                            color: Color(0xFFE5E7EB),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x33919EAB),
                                              offset: Offset(0, 0),
                                              blurRadius: 2,
                                              spreadRadius: 0,
                                            ),
                                          ],
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
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
