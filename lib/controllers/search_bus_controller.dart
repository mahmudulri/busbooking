import 'package:busbooking/models/bus_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../services/search_bus_service.dart';

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
      print(selectedDate.toString());
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

  int initialpage = 1;
  var isLoading = false.obs;

  var alltriplist = BusListModel().obs;

  void fetchBusTrip() async {
    try {
      isLoading(true);
      await BuslistApi()
          .fetchTrip(
            originCityId.toString(),
            destinationCityId.toString(),
            selectedDate.toString(),
          )
          .then((value) {
            alltriplist.value = value;

            isLoading(false);
          });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
