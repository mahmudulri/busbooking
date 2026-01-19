import 'package:busbooking/screens/bus_reserve_screen.dart';
import 'package:busbooking/utils/colors.dart';
import 'package:busbooking/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../globalcontroller/languages_controller.dart';
import '../globalcontroller/page_controller.dart';
import '../widgets/homeservicebox.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final languagesController = Get.find<LanguagesController>();
  final mypagecontroller = Get.find<Mypagecontroller>();

  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    print(currentIndex.toString());
  }

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // 🔑 Responsive values
    final headerHeight = screenHeight * 0.28;
    final contentTop = headerHeight - (screenHeight * 0.05);
    final floatingCardHeight = screenHeight * 0.10;
    final floatingCardTop = headerHeight - (floatingCardHeight * 0.87);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // keep transparent
        statusBarIconBrightness: Brightness.light, // Android icons
      ),
      child: Scaffold(
        body: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              //...........................Header area.......................//
              Container(
                height: headerHeight,
                width: screenWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/baseheader.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: Column(
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
                              child: Icon(Icons.menu, color: Colors.white),
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
                                                            "direction": "ltr",
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
                                                    color: Colors.grey.shade300,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                alignment: Alignment.centerLeft,
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
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/user.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 60,
                        width: screenWidth - 100,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            KText(
                              text: languagesController.tr("ACCOUNT_CREDIT"),
                              color: Colors.grey.shade300,
                              fontSize: 14,
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                KText(
                                  text: "7581",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                                SizedBox(width: 10),

                                KText(
                                  text: "AFN",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //...........................Main Body Area.......................//
              Positioned(
                top: contentTop,
                left: 0,
                right: 0,
                child: Container(
                  height: screenHeight,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.02,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 35),
                      Container(
                        height: 200,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/icons/fakeslider.png"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // color: Colors.cyan,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Homeservicebox(
                                      btnName: languagesController.tr(
                                        "BUS_RESERVATION",
                                      ),
                                      onpressed: () {
                                        mypagecontroller.changePage(
                                          BusReserveScreen(),
                                          isMainPage: false,
                                        );
                                      },
                                      imglink: "assets/images/busreserve.png",
                                      isActive: "yes",
                                    ),
                                    Homeservicebox(
                                      btnName: languagesController.tr(
                                        "FLIGHT_TICKET",
                                      ),
                                      imglink: "assets/images/flight.png",
                                    ),
                                    Homeservicebox(
                                      btnName: languagesController.tr(
                                        "TAXI_TICKET",
                                      ),
                                      imglink: "assets/images/taxi.png",
                                    ),
                                    Homeservicebox(
                                      btnName: languagesController.tr(
                                        "CITY_TAXI",
                                      ),
                                      imglink: "assets/images/citytaxi.png",
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Homeservicebox(
                                      btnName: languagesController.tr(
                                        "CREDIT_TRANSFER",
                                      ),
                                      imglink: "assets/images/credittrans.png",
                                    ),
                                    Homeservicebox(
                                      btnName: languagesController.tr(
                                        "INTERNET_PACKAGE",
                                      ),
                                      imglink: "assets/images/internetpack.png",
                                    ),
                                    Homeservicebox(
                                      btnName: languagesController.tr(
                                        "MONEY_TRANSFER",
                                      ),
                                      imglink: "assets/images/transfer.png",
                                    ),
                                    Homeservicebox(
                                      btnName: languagesController.tr(
                                        "CONVERSATION_PACKAGE",
                                      ),
                                      imglink:
                                          "assets/images/conversationpackeg.png",
                                    ),
                                  ],
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

              //...........................Balance Button Area............................//
              Positioned(
                top: floatingCardTop,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                child: GestureDetector(
                  onTap: () {
                    print(box.read("direction"));
                  },
                  child: Container(
                    height: floatingCardHeight,
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = 0;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                currentIndex == 0
                                    ? "assets/icons/creditfill.png"
                                    : "assets/icons/creditoutline.png",
                                height: screenHeight * 0.035,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                height: box.read("direction") == "ltr" ? 2 : 0,
                              ),

                              KText(
                                text: languagesController.tr("CREDIT"),
                                color: currentIndex == 0
                                    ? AppColors.primaryColor
                                    : Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = 1;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                currentIndex == 1
                                    ? "assets/icons/debitfill.png"
                                    : "assets/icons/debitoutline.png",
                                height: screenHeight * 0.035,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                height: box.read("direction") == "ltr" ? 2 : 0,
                              ),

                              KText(
                                text: languagesController.tr("DEBIT"),
                                color: currentIndex == 1
                                    ? AppColors.primaryColor
                                    : Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = 2;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                currentIndex == 2
                                    ? "assets/icons/salefill.png"
                                    : "assets/icons/saleoutline.png",
                                height: screenHeight * 0.035,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                height: box.read("direction") == "ltr" ? 2 : 0,
                              ),
                              KText(
                                text: languagesController.tr("SALE"),
                                color: currentIndex == 2
                                    ? AppColors.primaryColor
                                    : Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = 3;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                currentIndex == 3
                                    ? "assets/icons/profitfill.png"
                                    : "assets/icons/profitoutline.png",
                                height: screenHeight * 0.035,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                height: box.read("direction") == "ltr" ? 2 : 0,
                              ),
                              KText(
                                text: languagesController.tr("PROFIT"),
                                color: currentIndex == 3
                                    ? AppColors.primaryColor
                                    : Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
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
    );
  }
}
