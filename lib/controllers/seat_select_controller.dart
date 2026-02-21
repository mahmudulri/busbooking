import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeatSelectionController extends GetxController {
  // max seat limit
  final int maxSeat = 2;

  /// selected seat labels: ["A1", "B2"]
  final RxList<String> selectedSeats = <String>[].obs;

  /// seat prices map: {"A1": 500, "B2": 500}
  final RxMap<String, double> seatAmountMap = <String, double>{}.obs;

  /// total amount (reactive)
  double get totalAmount {
    if (seatAmountMap.isEmpty) return 0;
    return seatAmountMap.values.fold(0.0, (sum, item) => sum + item);
  }

  bool isSelected(String seatLabel) {
    return selectedSeats.contains(seatLabel);
  }

  void toggleSeat({required String seatLabel, required double price}) {
    if (isSelected(seatLabel)) {
      /// 🔁 unselect
      selectedSeats.remove(seatLabel);
      seatAmountMap.remove(seatLabel);

      /// 🔔 force refresh (IMPORTANT)
      seatAmountMap.refresh();
      selectedSeats.refresh();
    } else {
      /// 🚫 limit reached
      if (selectedSeats.length >= maxSeat) {
        Get.snackbar(
          backgroundColor: Colors.white,

          "Seat limit",
          "You can select maximum $maxSeat seats",
        );
        return;
      }

      /// ❌ ignore zero price seat
      if (price <= 0) {
        Get.snackbar("Invalid seat", "Seat price not available");
        return;
      }

      /// ✅ select
      selectedSeats.add(seatLabel);
      seatAmountMap[seatLabel] = price;

      /// 🔔 force refresh (IMPORTANT)
      seatAmountMap.refresh();
      selectedSeats.refresh();
    }
  }

  /// optional: clear all selections
  void clearSelection() {
    selectedSeats.clear();
    seatAmountMap.clear();
    selectedSeats.refresh();
    seatAmountMap.refresh();
  }
}
