import 'dart:convert';

import 'package:busbooking/models/bus_list_model.dart';
import 'package:busbooking/utils/api_endpoints.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class BuslistApi {
  final box = GetStorage();

  Future<BusListModel> fetchTrip(fromID, toID, date) async {
    final url = Uri.parse(
      ApiEndPoints.baseUrl +
          ApiEndPoints.otherendpoints.trips +
          "origin-city-id=$fromID&destination-city-id=$toID&passenger-count=1&departure-time=$date",
    );
    print(url);

    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
    );

    if (response.statusCode == 200) {
      // print(response.body.toString());

      final buslistModel = BusListModel.fromJson(json.decode(response.body));

      return buslistModel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
