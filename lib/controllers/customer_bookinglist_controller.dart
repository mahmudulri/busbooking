import 'package:get/get.dart';

import '../models/customer_booking_model.dart';
import '../models/seat_list_model.dart';
import '../services/customer_bookinglist_service.dart';
import '../services/seatplan_service.dart';

class CustomerBookinglistController extends GetxController {
  var isLoading = false.obs;

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
