import 'package:get/get.dart';
import '../models/ticket_response_model.dart';

class TicketResponseController extends GetxController {
  Rx<TicketResponseModel?> ticketResponse = Rx<TicketResponseModel?>(null);

  /// Set full response
  void setResponse(Map<String, dynamic> json) {
    ticketResponse.value = TicketResponseModel.fromJson(json);
  }

  /// Clear when needed
  void clear() {
    ticketResponse.value = null;
  }

  /// Helpers (optional)
  bool get hasData => ticketResponse.value != null;

  TicketResponseModel get data => ticketResponse.value!;
}
