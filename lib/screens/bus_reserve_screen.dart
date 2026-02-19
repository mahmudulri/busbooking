import 'package:busbooking/controllers/city_list_controller.dart';
import 'package:busbooking/controllers/sign_in_controller.dart';
import 'package:busbooking/utils/colors.dart';
import 'package:busbooking/widgets/custom_text.dart';
import 'package:busbooking/widgets/default_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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

  final box = GetStorage();

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
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          languagesController.tr("LANGUAGES"),
                                        ),
                                        content: SizedBox(
                                          height: 350,
                                          width: MediaQuery.of(
                                            context,
                                          ).size.width,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: languagesController
                                                .alllanguagedata
                                                .length,
                                            itemBuilder: (context, index) {
                                              final data = languagesController
                                                  .alllanguagedata[index];

                                              return GestureDetector(
                                                onTap: () {
                                                  final languageName =
                                                      data["name"].toString();

                                                  final matched =
                                                      languagesController
                                                          .alllanguagedata
                                                          .firstWhere(
                                                            (lang) =>
                                                                lang["name"] ==
                                                                languageName,
                                                            orElse: () => {
                                                              "isoCode": "en",
                                                              "direction":
                                                                  "ltr",
                                                            },
                                                          );

                                                  final languageISO =
                                                      matched["isoCode"]!;
                                                  final languageDirection =
                                                      matched["direction"]!;

                                                  // Save & apply
                                                  languagesController
                                                      .changeLanguage(
                                                        languageName,
                                                      );
                                                  box.write(
                                                    "language",
                                                    languageName,
                                                  );
                                                  box.write(
                                                    "direction",
                                                    languageDirection,
                                                  );

                                                  // Map iso → Locale
                                                  Locale locale;
                                                  switch (languageISO) {
                                                    case "fa":
                                                      locale = const Locale(
                                                        "fa",
                                                        "IR",
                                                      );
                                                      break;
                                                    case "ar":
                                                      locale = const Locale(
                                                        "ar",
                                                        "AE",
                                                      );
                                                      break;
                                                    case "ps":
                                                      locale = const Locale(
                                                        "ps",
                                                        "AF",
                                                      );
                                                      break;
                                                    case "tr":
                                                      locale = const Locale(
                                                        "tr",
                                                        "TR",
                                                      );
                                                      break;
                                                    case "bn":
                                                      locale = const Locale(
                                                        "bn",
                                                        "BD",
                                                      );
                                                      break;
                                                    case "en":
                                                    default:
                                                      locale = const Locale(
                                                        "en",
                                                        "US",
                                                      );
                                                  }

                                                  setState(() {
                                                    EasyLocalization.of(
                                                      context,
                                                    )!.setLocale(locale);
                                                  });

                                                  Navigator.pop(context);
                                                  debugPrint(
                                                    "🌐 Language: $languageName ($languageISO), dir: $languageDirection",
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: 5,
                                                  ),
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color:
                                                          Colors.grey.shade300,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    data["fullname"].toString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
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
                    height: 600,
                    width: screenWidth,
                    // color: Colors.red,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
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
                                            title: languagesController.tr(
                                              "EXIT",
                                            ),
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
                                            title: languagesController.tr(
                                              "ENTER",
                                            ),
                                            value: searchBusController
                                                .destinationCityName
                                                .value,
                                            cityController: citylistController,
                                          ),
                                        ],
                                      ),
                                      box.read("direction") == "ltr"
                                          ? Positioned(
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
                                                  borderRadius:
                                                      BorderRadius.circular(8),
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
                                            )
                                          : Positioned(
                                              left: 8,
                                              child: Container(
                                                height: 45,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey.shade300,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
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
                                                  text: languagesController.tr(
                                                    "NUMBER_OF_PASSENGER",
                                                  ),
                                                  fontSize: 11,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                KText(
                                                  text:
                                                      '(1) ${languagesController.tr("PASSENGER")}',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 11,
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
                                                      text: languagesController
                                                          .tr("MOVE_DATE"),
                                                      fontSize: 11,
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
                                                        fontSize: 11,
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
                        Container(
                          width: screenWidth,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                height: 80,
                                width: screenWidth,
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/comfort.png",
                                      width: 80,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: languagesController.tr(
                                              "COMFORT_OF_TRAVEL",
                                            ),
                                            color: Color(0xff1890FF),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          Expanded(
                                            child: KText(
                                              text: languagesController.tr(
                                                "COMFORT_TITLE",
                                              ),
                                              fontSize: 10,
                                              color: Color(0xff637381),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                height: 80,
                                width: screenWidth,
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/paymentsystem.png",
                                      width: 80,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: languagesController.tr(
                                              "FAST_AND_EASY_PAYMENT",
                                            ),
                                            color: Color(0xff00AB55),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          Expanded(
                                            child: KText(
                                              text: languagesController.tr(
                                                "PAYMENT_SYSTEM_TITLE",
                                              ),
                                              fontSize: 10,
                                              color: Color(0xff637381),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                height: 80,
                                width: screenWidth,
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/24hours.png",
                                      width: 80,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: languagesController.tr(
                                              "24_HOURS_SUPPORT",
                                            ),
                                            color: Color(0xffFF4842),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          Expanded(
                                            child: KText(
                                              text: languagesController.tr(
                                                "24_SUPPORT_TITLE",
                                              ),
                                              fontSize: 10,
                                              color: Color(0xff637381),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                height: 80,
                                width: screenWidth,
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/refundpolicy.png",
                                      width: 80,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: languagesController.tr(
                                              "REFUND_POLICY",
                                            ),
                                            color: Color(0xff00CED1),
                                            fontWeight: FontWeight.w700,
                                          ),
                                          Expanded(
                                            child: KText(
                                              text: languagesController.tr(
                                                "REFUND_TITLE",
                                              ),
                                              fontSize: 10,
                                              color: Color(0xff637381),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xff00CED1),
                              radius: 8,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 3,
                              ),
                            ),
                            SizedBox(width: 5),
                            KText(
                              text: languagesController.tr("RECENT_BOOKINGS"),
                              color: AppColors.boldfontColor,
                              fontWeight: FontWeight.w700,
                            ),
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),

                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 5,
                                ),
                                child: KText(
                                  text: languagesController.tr("SHOW_DETAILS"),
                                  color: AppColors.boldfontColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 150,
                          width: screenWidth,
                          color: Colors.red,
                        ),
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
                            KText(
                              text: languagesController.tr("ORIGIN"),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
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
                                          hintText: languagesController.tr(
                                            "SEARCH_FOR_CITY",
                                          ),
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
                        searchBusController.originCityName.value == "Select"
                            ? languagesController.tr("SELECT")
                            : searchBusController.originCityName.value,
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
                            KText(
                              text: languagesController.tr("DESTINATION"),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
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
                                          hintText: languagesController.tr(
                                            "SEARCH_FOR_CITY",
                                          ),
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
                        searchBusController.destinationCityName.value ==
                                "Select"
                            ? languagesController.tr("SELECT")
                            : searchBusController.destinationCityName.value,
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
