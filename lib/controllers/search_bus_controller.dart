import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SearchBusController extends GetxController {
  @override
  void onInit() {
    selectedDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    super.onInit();
  }

  RxString selectedDate = ''.obs;

  RxString originCityName = ''.obs;
  RxString originCityId = ''.obs;

  RxString destinationCityName = ''.obs;
  RxString destinationCityId = ''.obs;

  RxString passengerCount = '1'.obs;

  RxString tripDate = '2026-02-19'.obs;

  void pickDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year, now.month, now.day),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (pickedDate != null) {
      selectedDate.value = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  void swapLocation() {
    // temp variables
    final tempName = originCityName.value;
    final tempId = originCityId.value;

    // swap
    originCityName.value = destinationCityName.value;
    originCityId.value = destinationCityId.value;

    destinationCityName.value = tempName;
    destinationCityId.value = tempId;
  }
}
