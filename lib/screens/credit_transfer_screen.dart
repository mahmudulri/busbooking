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
import '../controllers/common_recharge_controller.dart';
import '../controllers/common_rechargelist_controller.dart';
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

  final CommonRechargelistController commonRechargelistController = Get.put(
    CommonRechargelistController(),
  );

  final CommonRechargeController commonRechargeController = Get.put(
    CommonRechargeController(),
  );

  final box = GetStorage();
  String selectedValue = "with";

  final Set<int> expandedIndexes = {};

  @override
  void initState() {
    super.initState();
    commonRechargelistController.finalList.clear();
    commonRechargelistController.initialpage = 1;
    commonRechargelistController.fetchrechargelist();
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
                                MyAuthTextfield(
                                  height: 55,
                                  keyboardType: TextInputType.phone,

                                  controller: phoneNumberController,
                                  hint: languagesController.tr(
                                    "DESTINATION_PHONE_NUMBER",
                                  ),
                                ),
                                SizedBox(height: 5),

                                MyAuthTextfield(
                                  keyboardType: TextInputType.phone,
                                  height: 55,
                                  controller: amountController,
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
                        SizedBox(height: 10),
                        Container(
                          height: 700,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Color(0xffEEF4FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              children: [
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
                                      text: languagesController.tr(
                                        "TRANSFER_HISTORY",
                                      ),
                                      color: AppColors.boldfontColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Container(
                                  height: 150,
                                  width: screenWidth,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8),
                                Expanded(
                                  child: Container(
                                    // color: Colors.red,
                                    child: Obx(
                                      () =>
                                          commonRechargelistController
                                                  .isLoading
                                                  .value ==
                                              false
                                          ? ListView.builder(
                                              padding: EdgeInsets.zero,
                                              itemCount:
                                                  commonRechargelistController
                                                      .finalList
                                                      .length,
                                              itemBuilder: (context, index) {
                                                final data =
                                                    commonRechargelistController
                                                        .finalList[index];
                                                final isExpanded =
                                                    expandedIndexes.contains(
                                                      index,
                                                    );

                                                return Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      // HEADER
                                                      ListTile(
                                                        title: Text(
                                                          data.mobile
                                                              .toString(),
                                                        ),
                                                        trailing: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            KText(
                                                              text: isExpanded
                                                                  ? ''
                                                                  : languagesController.tr(
                                                                      "VIEW_DETAILS",
                                                                    ),
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            const SizedBox(
                                                              width: 6,
                                                            ),
                                                            Icon(
                                                              isExpanded
                                                                  ? Icons
                                                                        .keyboard_arrow_up
                                                                  : Icons
                                                                        .keyboard_arrow_down,
                                                            ),
                                                          ],
                                                        ),
                                                        onTap: () {
                                                          if (isExpanded) {
                                                            expandedIndexes
                                                                .remove(index);
                                                          } else {
                                                            expandedIndexes.add(
                                                              index,
                                                            );
                                                          }
                                                          (context as Element)
                                                              .markNeedsBuild();
                                                        },
                                                      ),

                                                      // EXPANDED CONTENT
                                                      if (isExpanded)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                12.0,
                                                              ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  KText(
                                                                    text:
                                                                        "${languagesController.tr("STATUS")}",
                                                                  ),
                                                                  KText(
                                                                    text:
                                                                        "${data.status ?? ''}",
                                                                  ),
                                                                ],
                                                              ),

                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  KText(
                                                                    text:
                                                                        "${languagesController.tr("AMOUNT")}",
                                                                  ),
                                                                  KText(
                                                                    text:
                                                                        "${data.amount ?? ''}",
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  KText(
                                                                    text:
                                                                        "${languagesController.tr("DATE")}",
                                                                  ),
                                                                  KText(
                                                                    text: convertToDate(
                                                                      data.createdAt
                                                                          .toString(),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),

                                                              const SizedBox(
                                                                height: 12,
                                                              ),

                                                              // CLOSE BUTTON BELOW
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: TextButton(
                                                                  onPressed: () {
                                                                    expandedIndexes
                                                                        .remove(
                                                                          index,
                                                                        );
                                                                    (context
                                                                            as Element)
                                                                        .markNeedsBuild();
                                                                  },
                                                                  child: KText(
                                                                    text: languagesController
                                                                        .tr(
                                                                          "CLOSE",
                                                                        ),
                                                                    fontSize:
                                                                        11,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            )
                                          : Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),

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
