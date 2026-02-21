import 'dart:convert';

import 'package:busbooking/models/bus_list_model.dart';
import 'package:busbooking/utils/api_endpoints.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/seat_list_model.dart';

class SeatplanApi {
  final box = GetStorage();

  Future<SeatListModel> fetchseats(tripID) async {
    final url = Uri.parse(
      ApiEndPoints.baseUrl +
          ApiEndPoints.otherendpoints.seaitsplan +
          "${tripID}/show",
    );
    print(url);

    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
    );

    if (response.statusCode == 200) {
      // print(response.body.toString());

      final seatplanModel = SeatListModel.fromJson(json.decode(response.body));

      return seatplanModel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
