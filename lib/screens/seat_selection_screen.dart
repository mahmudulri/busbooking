import 'package:busbooking/controllers/seat_plan_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../globalcontroller/languages_controller.dart';
import '../globalcontroller/page_controller.dart';
import '../widgets/custom_text.dart';

class SeatSelectionScreen extends StatefulWidget {
  SeatSelectionScreen({super.key});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final mypagecontroller = Get.find<Mypagecontroller>();

  final languagesController = Get.find<LanguagesController>();

  final SeatPlanController seatPlanController = Get.put(SeatPlanController());
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    seatPlanController.fetchallseat();
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
                              text: languagesController.tr("SELECT_SEAT"),
                              color: Colors.white,
                              fontSize: 18,
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
                top: 120,
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
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 110,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Color(0xff2D2882),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                // color: Colors.red,
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: languagesController.tr("SEAT"),
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "A1",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                          ),
                                        ),
                                        Text(
                                          "A2",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  KText(
                                    textAlign: TextAlign.center,
                                    text: languagesController.tr(
                                      "NUMBER_OF_PASSENGER",
                                    ),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
                                  ),
                                  KText(
                                    textAlign: TextAlign.center,
                                    text: "104 People",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: Container(
                                // color: Colors.red,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    KText(
                                      text: languagesController.tr("AMOUNT"),
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                    Text(
                                      "700",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Center(
                              child: KText(
                                text: languagesController.tr(
                                  "CONFIRMATION_AND_PAYMENT",
                                ),
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
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
      ),
    );
  }
}
