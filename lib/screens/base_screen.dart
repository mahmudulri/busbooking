import 'dart:io';

import 'package:busbooking/pages/homepage.dart';
import 'package:busbooking/pages/network_page.dart';
import 'package:busbooking/pages/order_page.dart';
import 'package:busbooking/pages/transaction_page.dart';
import 'package:busbooking/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../globalcontroller/languages_controller.dart';
import '../globalcontroller/page_controller.dart';
import '../globalcontroller/scaffold_controller.dart';
import '../utils/colors.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final scaffoldController = Get.find<ScaffoldController>();
  final mypagecontroller = Get.find<Mypagecontroller>();
  final languagesController = Get.find<LanguagesController>();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> showExitPopup() async {
    final shouldExit = mypagecontroller.goBack();
    if (shouldExit) {
      return await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.exit_to_app_rounded,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      languagesController.tr("EXIT_APP"),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              content: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  languagesController.tr("DO_YOU_WANT_TO_EXIT_APP"),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ),
              actionsPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                        child: Text(
                          languagesController.tr("NO"),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          exit(0);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          languagesController.tr("YES"),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ) ??
          false;
    }
    setState(() {}); // Rebuild screen after popping
    return false;
  }

  @override
  void initState() {
    super.initState();
    mypagecontroller.setUpdateIndexCallback(_onItemTapped);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        key: scaffoldController.scaffoldKey, // 🔑 VERY IMPORTANT
        drawer: DrawerWidget(),
        body: Obx(() => mypagecontroller.pageStack.last),
        bottomNavigationBar: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              /// 🟢 Bottom White Navigation Bar
              Container(
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: BottomAppBar(
                    elevation: 0,
                    shape: const CircularNotchedRectangle(),
                    notchMargin: 12,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _navItem(
                          icon: "assets/icons/newhome.png",
                          index: 0,
                          label: languagesController.tr("HOME"),
                          page: Homepage(),
                        ),
                        _navItem(
                          icon: "assets/icons/newtrans.png",
                          index: 1,
                          label: languagesController.tr("TRANSACTIONS"),
                          page: TransactionPage(),
                        ),

                        SizedBox(width: 45),
                        _navItem(
                          icon: "assets/icons/neworder.png",
                          index: 2,
                          label: languagesController.tr("ORDERS"),
                          page: OrderPage(),
                        ),
                        _navItem(
                          icon: "assets/icons/newnetwork.png",
                          index: 3,
                          label: languagesController.tr("NETWORK"),
                          page: NetworkPage(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              /// 🔴 Floating Red Button (INSIDE GREEN)
              Positioned(
                bottom: 22, // 🔑 green container-এর ভিতরে থাকবে
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(FontAwesomeIcons.user, size: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required String icon,
    required int index,
    required String label,
    required Widget page,
  }) {
    return Obx(() {
      final isActive = mypagecontroller.lastSelectedIndex.value == index;

      return MaterialButton(
        minWidth: 40,
        onPressed: () {
          mypagecontroller.changePage(page);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, height: 25),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isActive ? AppColors.primaryColor : Colors.black,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ],
        ),
      );
    });
  }
}
