import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';
import '../services/customer_trans_service.dart';

class CustomerTransListController extends GetxController {
  @override
  void onInit() {
    fromDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    toDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    super.onInit();
  }

  RxString fromDate = ''.obs;
  RxString toDate = ''.obs;
  var isLoading = false.obs;

  var alltransactions = TransactionsModel().obs;

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

  void fetchtransactions() async {
    try {
      isLoading(true);
      await CustomerTranstionApi().fetchlist().then((value) {
        alltransactions.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
