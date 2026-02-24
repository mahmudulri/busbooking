import 'package:busbooking/controllers/city_list_controller.dart';
import 'package:busbooking/controllers/sign_in_controller.dart';
import 'package:busbooking/utils/colors.dart';
import 'package:busbooking/widgets/auth_textfield.dart';
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
import '../controllers/customer_bookinglist_controller.dart';
import '../controllers/search_bus_controller.dart';
import '../draft.dart';
import '../globalcontroller/languages_controller.dart';
import '../globalcontroller/page_controller.dart';
import '../helpers/datetime_helper.dart';
import 'bus_search_result_screen.dart';

class CreditTransferScreen extends StatefulWidget {
  CreditTransferScreen({super.key});

  @override
  State<CreditTransferScreen> createState() => _CreditTransferScreenState();
}

class _CreditTransferScreenState extends State<CreditTransferScreen> {
  final mypagecontroller = Get.find<Mypagecontroller>();

  final CustomerBookinglistController bookinglistController = Get.put(
    CustomerBookinglistController(),
  );

  final box = GetStorage();
  String selectedValue = "with";

  @override
  void initState() {
    super.initState();
  }

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();

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
                              GestureDetector(
                                onTap: () {
                                  bookinglistController.fetchbookinglist();
                                },
                                child: KText(
                                  text: languagesController.tr(
                                    "CREDIT_TRANSFER",
                                  ),
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: KText(
                                          text: languagesController.tr(
                                            "LANGUAGES",
                                          ),
                                          fontSize: 15,
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
                      color: Colors.cyan,
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
                                AuthTextfield(
                                  height: 55,

                                  controller: phoneNumberController,
                                  hint: languagesController.tr(
                                    "DESTINATION_PHONE_NUMBER",
                                  ),
                                ),
                                SizedBox(height: 5),

                                AuthTextfield(
                                  height: 55,
                                  controller: phoneNumberController,
                                  hint: languagesController.tr(
                                    "TRANSFER_AMOUNT",
                                  ),
                                ),

                                SizedBox(height: 5),
                                RadioGroup<String>(
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value!;
                                      print(value.toString());
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Radio<String>(
                                        value: "with",
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                      KText(
                                        text: languagesController.tr(
                                          "WITH_COMMISSION",
                                        ),
                                        fontSize: 12,
                                      ),

                                      const SizedBox(width: 8),

                                      Radio<String>(
                                        value: "without",
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                      KText(
                                        text: languagesController.tr(
                                          "WITHOUT_COMMISSION",
                                        ),
                                        fontSize: 12,
                                      ),
                                    ],
                                  ),
                                ),
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
                                        "SEND_TO_DESTINATION",
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

                        SizedBox(height: 20),
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
