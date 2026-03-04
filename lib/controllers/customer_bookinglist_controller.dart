import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/customer_booking_model.dart';
import '../models/seat_list_model.dart';
import '../services/customer_bookinglist_service.dart';
import '../services/seatplan_service.dart';

class CustomerBookinglistController extends GetxController {
  @override
  void onInit() {
    fromDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    toDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    super.onInit();
  }

  var isLoading = false.obs;
  RxString fromDate = ''.obs;
  RxString toDate = ''.obs;

  void pickfromDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year, now.month, now.day),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (pickedDate != null) {
      fromDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  void picktoDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year, now.month, now.day),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (pickedDate != null) {
      toDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  var allbookinglist = CustomerBookingsModel().obs;

  void fetchbookinglist() async {
    try {
      isLoading(true);
      await CustomerBookinglistApi().fetchbookings().then((value) {
        allbookinglist.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
