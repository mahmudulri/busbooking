import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/homepage.dart';
import '../pages/network_page.dart';
import '../pages/order_page.dart';
import '../pages/transaction_page.dart';
import '../screens/bus_search_result_screen.dart';

class Mypagecontroller extends GetxController {
  /// Navigation stack
  RxList<Widget> pageStack = <Widget>[Homepage()].obs;

  Rx<Color> backgroundColor = const Color(0xFFFFFFFF).obs;
  void setBaseScreenBg(Color color) {
    backgroundColor.value = color;
  }

  void resetBaseScreenBg() {
    backgroundColor.value = const Color(0xFFFFFFFF);
  }

  /// Bottom navigation selected index
  RxInt lastSelectedIndex = 0.obs;

  /// Main (bottom nav) pages
  final List<Widget> mainPages = [
    Homepage(), // index 0
    TransactionPage(), // index 1
    OrderPage(), // index 2
    NetworkPage(), // index 3
  ];

  Function(int)? updateIndexCallback;

  void setUpdateIndexCallback(Function(int) callback) {
    updateIndexCallback = callback;
  }

  /// 🔹 Cleaner helper getters
  bool get isHomeSelected => lastSelectedIndex.value == 0;

  bool get isRootPage => pageStack.length == 1;

  bool get isHomeRoot => isHomeSelected && isRootPage;

  /// 🔹 Change page handler
  void changePage(Widget page, {bool isMainPage = true}) {
    if (page is BusSearchResultScreen) {
      backgroundColor.value = const Color(0xFF2E2982);
    } else {
      backgroundColor.value = const Color(0xFFFFFFFF);
    }

    if (isMainPage) {
      lastSelectedIndex.value = mainPages.indexWhere(
        (element) => element.runtimeType == page.runtimeType,
      );
      pageStack.value = [page];
    } else {
      pageStack.add(page);
    }

    updateIndexCallback?.call(isMainPage ? lastSelectedIndex.value : -1);
  }

  /// 🔹 Back navigation handler
  bool goBack() {
    if (pageStack.length > 1) {
      pageStack.removeLast();
      backgroundColor.value = const Color(0xFFFFFFFF);
      return false; // Don't exit app
    }
    return true; // Exit app
  }

  /// 🔹 Navigate using bottom nav index

  // void goToMainPageByIndex(int index) {
  //   lastSelectedIndex.value = index;
  //   pageStack.value = [mainPages[index]];
  //   updateIndexCallback?.call(index);
  // }
}
