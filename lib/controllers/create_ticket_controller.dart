import 'dart:convert';

import 'package:busbooking/widgets/ticket_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../globalcontroller/languages_controller.dart';
import '../helpers/buildticket_helper.dart';
import '../utils/api_endpoints.dart';
import 'customer_profile_controller.dart';
import 'seat_plan_controller.dart';
import 'seat_select_controller.dart';
import 'ticket_details_controller.dart';
import 'ticket_response_controller.dart';

class CreateTicketController extends GetxController {
  TextEditingController numberController = TextEditingController();

  LanguagesController languagesController = Get.put(LanguagesController());
  CustomerProfileController customerProfileController = Get.put(
    CustomerProfileController(),
  );

  SeatPlanController tripDetailsController = Get.put(SeatPlanController());

  SeatSelectionController seatSelectionController = Get.put(
    SeatSelectionController(),
  );
  final TicketResponseController ticketResponseController = Get.put(
    TicketResponseController(),
    permanent: true,
  );

  TicketDetailsController ticketDetailsController = Get.put(
    TicketDetailsController(),
  );
  final box = GetStorage();

  RxBool isLoading = false.obs;
  RxString tripId = ''.obs;
  RxString amount = ''.obs;

  void addSeat(int seatPriceId) {
    // already selected?
    final exists = tickets.any((t) => t["trip_seat_price_id"] == seatPriceId);

    if (exists) return;

    // LIMIT: max 2 seats
    if (tickets.length >= 2) {
      return;
    }

    final ticket = buildTicket(seatPriceId, customerProfileController);
    tickets.add(ticket!);
  }

  void removeSeat(int seatPriceId) {
    tickets.removeWhere((t) => t["trip_seat_price_id"] == seatPriceId);
  }

  RxList<Map<String, dynamic>> tickets = <Map<String, dynamic>>[].obs;

  RxBool isPhoneValid = false.obs;

  @override
  void onInit() {
    super.onInit();

    numberController.addListener(_validatePhone);
  }

  @override
  void onClose() {
    numberController.dispose();
    super.onClose();
  }

  void _validatePhone() {
    final text = numberController.text;

    if (text.length == 10 && text.startsWith('07')) {
      isPhoneValid.value = true;
    } else {
      isPhoneValid.value = false;
    }
  }

  Future<void> createnow(BuildContext context) async {
    try {
      isLoading.value = true;
      var url = Uri.parse("${ApiEndPoints.baseUrl}customer/bookings");
      Map body = {
        'trip_id': tripId.value,
        'is_partial_payment': "0",
        'amount': amount.value,
        'tickets': jsonEncode(tickets.toList()),
      };
      print(body.toString());

      http.Response response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read("userToken")}',
        },
      );

      final orderResults = jsonDecode(response.body);
      // print(response.statusCode.toString());
      // print(response.body.toString());
      if (response.statusCode == 200 && orderResults["success"] == true) {
        isLoading.value = false;

        ticketResponseController.setResponse(orderResults);

        numberController.clear();

        tripId.value = '';
        seatSelectionController.clearSelection();
        tickets.clear();
        tripDetailsController.fetchallseat(box.read("tripId"));

        showSuccessDialog(context);
      } else {
        isLoading.value = false;
        showErrorDialog(context, orderResults["message"]);
        print(orderResults["message"]);
      }
    } catch (e) {
      isLoading.value = false;
      showErrorDialog(context, e.toString());
    }
  }

  void handleFailure(String message) {
    isLoading.value = false;
  }

  void showSuccessDialog(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (context) {
        return ViewTicketWidget(
          ticketID: ticketResponseController
              .ticketResponse
              .value!
              .body!
              .item!
              .id
              .toString(),
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String errorMessage) {
    var screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: 350,
            width: screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(languagesController.tr("FAILED")),
                SizedBox(height: 15),
                Text(
                  languagesController.tr("BOOKING_FAILED"),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close error dialog
                    Navigator.pop(context); // Close main dialog
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(
                    languagesController.tr("CLOSE"),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
