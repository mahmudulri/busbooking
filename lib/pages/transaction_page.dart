import 'package:busbooking/helpers/datetime_helper.dart';
import 'package:busbooking/utils/colors.dart';
import 'package:busbooking/widgets/auth_textfield.dart';
import 'package:busbooking/widgets/custom_text.dart';
import 'package:busbooking/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/customer_trans_controller.dart';
import '../controllers/search_bus_controller.dart';
import '../globalcontroller/languages_controller.dart';
import '../globalcontroller/page_controller.dart';
import '../globalcontroller/scaffold_controller.dart';

class TransactionPage extends StatefulWidget {
  TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final mypagecontroller = Get.find<Mypagecontroller>();

  CustomerTransListController transListController = Get.put(
    CustomerTransListController(),
  );

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    transListController.fetchtransactions();
  }

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final languagesController = Get.find<LanguagesController>();
  final scaffoldController = Get.find<ScaffoldController>();

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
                                onTap: () {},
                                child: KText(
                                  text: languagesController.tr("TRANSACTIONS"),
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  scaffoldController.openDrawer();
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
                                Container(
                                  height: 50,
                                  width: screenWidth,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF9FAFB),
                                    borderRadius: BorderRadius.circular(12),
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            KText(
                                              text: languagesController.tr(
                                                "FROM_DATE",
                                              ),
                                              fontSize: 11,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            Obx(
                                              () => KText(
                                                text: transListController
                                                    .fromDate
                                                    .value,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () => transListController
                                              .pickfromDate(context),
                                          child: Icon(
                                            Icons.calendar_month_outlined,
                                            color: AppColors.primaryColor
                                                .withOpacity(0.50),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 50,
                                  width: screenWidth,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF9FAFB),
                                    borderRadius: BorderRadius.circular(12),
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            KText(
                                              text: languagesController.tr(
                                                "TO_DATE",
                                              ),
                                              fontSize: 11,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            Obx(
                                              () => KText(
                                                text: transListController
                                                    .toDate
                                                    .value,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () => transListController
                                              .picktoDate(context),
                                          child: Icon(
                                            Icons.calendar_month_outlined,
                                            color: AppColors.primaryColor
                                                .withOpacity(0.50),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DefaultButton(
                                        height: 45,
                                        onTap: () {},
                                        child: Center(
                                          child: KText(
                                            text: languagesController.tr(
                                              "APPLY_FILTER",
                                            ),
                                            color: Colors.white,
                                            fontSize: screenHeight * 0.015,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: DefaultButton(
                                        backgroundColor: Colors.white,
                                        borderColor: Colors.red,
                                        height: 45,
                                        onTap: () {},
                                        child: Center(
                                          child: KText(
                                            text: languagesController.tr(
                                              "CLEAR_FILTER",
                                            ),
                                            color: Colors.red,
                                            fontSize: screenHeight * 0.015,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        Container(
                          height: 600,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: Container(
                              child: Obx(
                                () =>
                                    transListController.isLoading.value == false
                                    ? ListView.builder(
                                        padding: EdgeInsets.all(0),
                                        itemCount: transListController
                                            .alltransactions
                                            .value
                                            .body!
                                            .items!
                                            .length,
                                        itemBuilder: (context, index) {
                                          final data = transListController
                                              .alltransactions
                                              .value
                                              .body!
                                              .items![index];
                                          return Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            width: screenWidth,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color:
                                                    data.type.toString() ==
                                                        "debit"
                                                    ? Colors.red
                                                    : Colors.green,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          data.type
                                                                  .toString() ==
                                                              "debit"
                                                          ? Colors.red
                                                                .withOpacity(
                                                                  0.30,
                                                                )
                                                          : Colors.green
                                                                .withOpacity(
                                                                  0.30,
                                                                ),
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                  8,
                                                                ),
                                                          ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          KText(
                                                            text: convertToDate(
                                                              data.createdAt
                                                                  .toString(),
                                                            ),
                                                            fontSize: 12,
                                                            color: Colors
                                                                .grey
                                                                .shade600,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    // color: Colors.yellow,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          KText(
                                                            text: languagesController.tr(
                                                              "TRANSACTION_TYPE",
                                                            ),
                                                            fontSize: 12,
                                                            color: Colors
                                                                .grey
                                                                .shade600,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  data.type
                                                                          .toString() ==
                                                                      "debit"
                                                                  ? Colors.red
                                                                        .withOpacity(
                                                                          0.30,
                                                                        )
                                                                  : Colors.green
                                                                        .withOpacity(
                                                                          0.30,
                                                                        ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    8,
                                                                  ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical: 4,
                                                                  ),
                                                              child: KText(
                                                                text:
                                                                    data.type
                                                                            .toString() ==
                                                                        "debit"
                                                                    ? languagesController.tr(
                                                                        "DEPOSIT_AMOUNT",
                                                                      )
                                                                    : languagesController.tr(
                                                                        "RECEIVE_AMOUNT",
                                                                      ),
                                                                fontSize: 12,
                                                                color:
                                                                    data.type
                                                                            .toString() ==
                                                                        "debit"
                                                                    ? Colors.red
                                                                    : Colors
                                                                          .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    // color: Colors.red,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          KText(
                                                            text:
                                                                languagesController
                                                                    .tr(
                                                                      "AMOUNT",
                                                                    ),
                                                            fontSize: 12,
                                                            color: Colors
                                                                .grey
                                                                .shade600,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          KText(
                                                            text: data.amount
                                                                .toString(),
                                                            fontSize: 12,
                                                            color: Colors
                                                                .grey
                                                                .shade600,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(),
                                      ),
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
      ),
    );
  }
}
