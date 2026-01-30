import 'package:busbooking/controllers/city_list_controller.dart';
import 'package:busbooking/utils/colors.dart';
import 'package:busbooking/widgets/custom_text.dart';
import 'package:busbooking/widgets/default_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/search_bus_controller.dart';
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

  final citylistController = Get.find<CityListController>();
  final searchBusController = Get.find<SearchBusController>();

  // String origin = "Fayzabad";
  // String destination = "Jur";

  @override
  void initState() {
    super.initState();

    citylistController.fetchAllCities();
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
                          height: 275,
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
                                          originselectionCard(
                                            type: languagesController.tr(
                                              "ORIGIN",
                                            ),
                                            title: "Exit",
                                            value: searchBusController
                                                .originCityName
                                                .value,
                                            cityController: citylistController,

                                            context: context,
                                          ),
                                          SizedBox(height: 5),
                                          destiselectionCard(
                                            context: context,
                                            type: languagesController.tr(
                                              "DESTINATION",
                                            ),
                                            title: "Enter",
                                            value: searchBusController
                                                .destinationCityName
                                                .value,
                                            cityController: citylistController,
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
                                            onPressed: searchBusController
                                                .swapLocation,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 60,
                                  width: screenWidth,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF9FAFB),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
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
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                KText(
                                                  text: 'Number of passenger',
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                KText(
                                                  text: '1 passenger (s)',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 13,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF9FAFB),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
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
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    KText(
                                                      text: 'Move date',
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    Obx(
                                                      () => KText(
                                                        text:
                                                            searchBusController
                                                                .selectedDate
                                                                .value,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () =>
                                                      searchBusController
                                                          .pickDate(context),
                                                  child: Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    color: AppColors
                                                        .primaryColor
                                                        .withOpacity(0.50),
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
                                SizedBox(height: 5),
                                DefaultButton(
                                  onTap: () {
                                    mypagecontroller.changePage(
                                      BusSearchResultScreen(),
                                      isMainPage: false,
                                    );
                                    searchBusController.fetchBusTrip();
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

final searchBusController = Get.find<SearchBusController>();

Widget originselectionCard({
  required BuildContext context,
  required String title,
  required String type,
  required String value,

  required CityListController cityController,
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
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.white,
                      insetPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ), // full width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 550,
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Origin",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 50,

                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/location.png",
                                      height: 22,
                                      color: Colors.grey.shade800,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextField(
                                        controller:
                                            cityController.searchController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Search for city",
                                          hintStyle: TextStyle(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 8),

                            Expanded(
                              child: Obx(
                                () => ListView.separated(
                                  itemCount:
                                      cityController.filteredCities.length,
                                  separatorBuilder: (_, __) => Divider(),
                                  itemBuilder: (context, index) {
                                    final city =
                                        cityController.filteredCities[index];
                                    return InkWell(
                                      onTap: () {
                                        searchBusController
                                                .originCityName
                                                .value =
                                            city.name ?? '';
                                        searchBusController.originCityId.value =
                                            city.id.toString();
                                        print(
                                          searchBusController
                                              .originCityId
                                              .value,
                                        );
                                        print(
                                          searchBusController
                                              .originCityName
                                              .value,
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_on, size: 20),
                                            SizedBox(width: 10),
                                            Text(
                                              city.name ?? '',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            // SizedBox(width: 10),
                                            // Text("-"),
                                            // SizedBox(width: 10),
                                            // Text(
                                            //   city.id.toString(),
                                            //   style: TextStyle(
                                            //     fontSize: 16,
                                            //     fontWeight: FontWeight.w500,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Obx(
                      () => Text(
                        searchBusController.originCityName.value,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
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
  );
}

Widget destiselectionCard({
  required BuildContext context,
  required String title,
  required String type,
  required String value,

  required CityListController cityController,
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
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.white,
                      insetPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ), // full width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 550,
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Destination",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 50,

                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/location.png",
                                      height: 22,
                                      color: Colors.grey.shade800,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextField(
                                        controller:
                                            cityController.searchController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Search for city",
                                          hintStyle: TextStyle(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 8),

                            Expanded(
                              child: Obx(
                                () => ListView.separated(
                                  itemCount:
                                      cityController.filteredCities.length,
                                  separatorBuilder: (_, __) => Divider(),
                                  itemBuilder: (context, index) {
                                    final city =
                                        cityController.filteredCities[index];
                                    return InkWell(
                                      onTap: () {
                                        searchBusController
                                                .destinationCityName
                                                .value =
                                            city.name ?? '';
                                        searchBusController
                                            .destinationCityId
                                            .value = city.id
                                            .toString();
                                        print(
                                          searchBusController
                                              .destinationCityId
                                              .value,
                                        );
                                        print(
                                          searchBusController
                                              .destinationCityName
                                              .value,
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_on, size: 20),
                                            SizedBox(width: 10),
                                            Text(
                                              city.name ?? '',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Obx(
                      () => Text(
                        searchBusController.destinationCityName.value,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
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
  );
}
