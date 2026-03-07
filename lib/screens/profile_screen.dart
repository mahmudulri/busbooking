import 'package:busbooking/controllers/city_list_controller.dart';
import 'package:busbooking/screens/bus_reserve_screen.dart';
import 'package:busbooking/utils/colors.dart';
import 'package:busbooking/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/customer_profile_controller.dart';
import '../controllers/search_bus_controller.dart';
import '../controllers/wallet_controller.dart';
import '../draftpage/sampleticketwidget.dart';
import '../globalcontroller/languages_controller.dart';
import '../globalcontroller/page_controller.dart';
import '../globalcontroller/scaffold_controller.dart';
import '../screens/credit_transfer_screen.dart';
import '../widgets/drawer.dart';
import '../widgets/homeservicebox.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final scaffoldController = Get.find<ScaffoldController>();
  final languagesController = Get.find<LanguagesController>();
  final mypagecontroller = Get.find<Mypagecontroller>();
  final walletcontroller = Get.find<WalletController>();

  CustomerProfileController customerProfileController = Get.put(
    CustomerProfileController(),
  );

  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // 🔑 Responsive values
    final headerHeight = screenHeight * 0.28;
    final contentTop = headerHeight - (screenHeight * 0.10);
    final floatingCardHeight = screenHeight * 0.10;
    final floatingCardTop = headerHeight - (floatingCardHeight * 0.87);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // keep transparent
        statusBarIconBrightness: Brightness.light, // Android icons
      ),
      child: PopScope(
        canPop: false,

        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;

          mypagecontroller.goBack();
        },

        child: Scaffold(
          drawer: DrawerWidget(),
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
                              GestureDetector(
                                onTap: () {},
                                child: KText(
                                  text: languagesController.tr("PROFILE"),
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
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
                        Expanded(
                          child: Container(
                            // color: Colors.cyan,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.black87,
                                    child: Center(
                                      child: Icon(
                                        Icons.person,
                                        size: 90,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  profileitemBox(
                                    languagesController.tr("FULL_NAME"),
                                    customerProfileController
                                            .profileData
                                            .value
                                            .body!
                                            .profile!
                                            .firstName
                                            .toString() +
                                        customerProfileController
                                            .profileData
                                            .value
                                            .body!
                                            .profile!
                                            .lastName
                                            .toString(),
                                  ),
                                  profileitemBox(
                                    languagesController.tr("EMAIL"),
                                    customerProfileController
                                        .profileData
                                        .value
                                        .body!
                                        .profile!
                                        .email
                                        .toString(),
                                  ),
                                  profileitemBox(
                                    languagesController.tr("PHONE_NUMBER"),
                                    customerProfileController
                                        .profileData
                                        .value
                                        .body!
                                        .profile!
                                        .mobile
                                        .toString(),
                                  ),
                                  profileitemBox(
                                    languagesController.tr("ACCOUNT_BALANCE"),
                                    walletcontroller.wallet.value.body!.balance
                                        .toString(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileitemBox(String boxname, String data) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      height: 50,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Color(0xffF4F6F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            KText(
              text: boxname.toString(),
              color: AppColors.defaultFontColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            KText(
              text: data.toString(),
              color: AppColors.boldfontColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ],
        ),
      ),
    );
  }
}
