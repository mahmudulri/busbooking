import 'package:get/get.dart';
import '../models/ticket_details_model.dart';

import '../services/ticket_details_service.dart';

class TicketDetailsController extends GetxController {
  var isLoading = false.obs;

  var ticketdetails = TicketDetailsModel().obs;

  void fetchticketDetails(String id) async {
    try {
      isLoading(true);
      await TicketDetailsApi().fetchdetails(id).then((value) {
        ticketdetails.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
