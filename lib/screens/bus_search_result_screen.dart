import 'package:busbooking/helpers/datetime_helper.dart';
import 'package:busbooking/utils/colors.dart';
import 'package:busbooking/widgets/custom_text.dart';
import 'package:busbooking/widgets/default_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/search_bus_controller.dart';
import '../draft.dart';

import '../globalcontroller/languages_controller.dart';
import '../globalcontroller/page_controller.dart';
import '../widgets/dottedline.dart';
import 'draftseatscreen.dart';
import 'seat_selection_screen.dart';

class BusSearchResultScreen extends StatefulWidget {
  BusSearchResultScreen({super.key});

  @override
  State<BusSearchResultScreen> createState() => _BusSearchResultScreenState();
}

class _BusSearchResultScreenState extends State<BusSearchResultScreen> {
  final searchBusController = Get.find<SearchBusController>();
  final mypagecontroller = Get.find<Mypagecontroller>();

  final languagesController = Get.find<LanguagesController>();

  TextEditingController fromController = TextEditingController();

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
                                fontSize: 18,
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
                      child: Obx(() {
                        // loading state
                        if (searchBusController.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        }

                        final items =
                            searchBusController.alltriplist.value.body?.items;

                        // empty state
                        if (items == null || items.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.directions_bus_outlined,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  languagesController.tr("NO_TRIP_FOUND"),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        // data state
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(0.0),
                          itemCount: searchBusController
                              .alltriplist
                              .value
                              .body!
                              .items!
                              .length,
                          itemBuilder: (context, index) {
                            final data = searchBusController
                                .alltriplist
                                .value
                                .body!
                                .items![index];
                            return GestureDetector(
                              onTap: () {
                                mypagecontroller.changePage(
                                  SeatSelectionScreen(
                                    tripId: data.id.toString(),
                                  ),
                                  isMainPage: false,
                                );
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
                                        height: 230,
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
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
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
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 20,
                                                              backgroundColor:
                                                                  Colors.teal,
                                                            ),
                                                            SizedBox(width: 5),
                                                            KText(
                                                              text:
                                                                  data
                                                                      .bus!
                                                                      .busNumber
                                                                      .toString() +
                                                                  data
                                                                      .vendor!
                                                                      .longName
                                                                      .toString(),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ],
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
                                                                      text: data
                                                                          .route!
                                                                          .originCity!
                                                                          .name
                                                                          .toString(),
                                                                      fontSize:
                                                                          12,
                                                                    ),

                                                                    KText(
                                                                      text: convertToLocalTime(
                                                                        data.departureTime
                                                                            .toString(),
                                                                      ),
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                    KText(
                                                                      text: data
                                                                          .route!
                                                                          .originStation!
                                                                          .name
                                                                          .toString(),
                                                                      fontSize:
                                                                          12,
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
                                                                      height:
                                                                          20,
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
                                                                        text: data
                                                                            .route!
                                                                            .destinationCity!
                                                                            .name
                                                                            .toString(),
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                      KText(
                                                                        text: convertToLocalTime(
                                                                          data.arrivalTime
                                                                              .toString(),
                                                                        ),
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                      KText(
                                                                        text: data
                                                                            .route!
                                                                            .destinationStation!
                                                                            .name
                                                                            .toString(),
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
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              DottedLine(),

                                              Container(
                                                height: 70,
                                                width: screenWidth,
                                                // color: Colors.cyan,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Row(
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
                                                                  SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  KText(
                                                                    text:
                                                                        data.availableSeats
                                                                            .toString() +
                                                                        " " +
                                                                        languagesController.tr(
                                                                          "EMPTY_SEAT",
                                                                        ),
                                                                    fontSize:
                                                                        13,
                                                                    color: AppColors
                                                                        .defaultFontColor,
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
                                                                  text: languagesController.tr(
                                                                    "TOTAL_PRICE",
                                                                  ),
                                                                  fontSize: 13,
                                                                  color: AppColors
                                                                      .defaultFontColor,
                                                                ),
                                                                Text(" : "),
                                                                KText(
                                                                  text: data
                                                                      .ticketPrice
                                                                      .toString(),
                                                                  fontSize: 13,
                                                                  color: AppColors
                                                                      .boldfontColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 15),
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
                                        top: 50,
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
                                        top: 50,
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
                        );
                      }),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 50,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Color(0xff2D2882),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    searchBusController.previousDate();
                                    searchBusController.fetchBusTrip();
                                  },
                                  child: KText(
                                    text: languagesController.tr(
                                      "PREVIOUS_DAY",
                                    ),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 1,
                            child: Obx(
                              () => KText(
                                textAlign: TextAlign.center,
                                text: searchBusController.selectedDate.value
                                    .toString(),
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    searchBusController.nextDate();
                                    searchBusController.fetchBusTrip();
                                  },
                                  child: KText(
                                    text: languagesController.tr("NEXT_DAY"),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                                Icon(
                                  FontAwesomeIcons.chevronRight,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
