import 'package:busbooking/pages/homepage.dart';
import 'package:busbooking/pages/network_page.dart';
import 'package:busbooking/pages/order_page.dart';
import 'package:busbooking/pages/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../globalcontroller/languages_controller.dart';
import '../utils/colors.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final languagesController = Get.find<LanguagesController>();
  int currentIndex = 0;

  late Widget currentPage;

  final List<Widget> _pages = [
    Homepage(),
    TransactionPage(),
    OrderPage(),
    NetworkPage(),
  ];

  @override
  void initState() {
    super.initState();
    currentPage = Homepage();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: currentPage,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

                      SizedBox(width: 60),
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
    );
  }

  Widget _navItem({
    required String icon,
    required int index,
    required String label,
    required Widget page,
  }) {
    final isActive = currentIndex == index;

    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        setState(() {
          currentIndex = index;
          currentPage = page;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon.toString(), height: 25),
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
  }
}
