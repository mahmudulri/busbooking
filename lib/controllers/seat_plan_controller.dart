import 'package:get/get.dart';

import '../models/seat_list_model.dart';
import '../services/seatplan_service.dart';

class SeatPlanController extends GetxController {
  var isLoading = false.obs;

  var allseatlist = SeatListModel().obs;

  void fetchallseat(id) async {
    try {
      isLoading(true);
      await SeatplanApi().fetchseats(id).then((value) {
        allseatlist.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
