import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/common_recharge_model.dart';
import '../utils/api_endpoints.dart';

class CommonrechagrlistApi {
  final box = GetStorage();
  Future<CommonRechargeModel> fetchlist() async {
    final url = Uri.parse(
      ApiEndPoints.baseUrl + ApiEndPoints.otherendpoints.commonrecharges,
    );
    print("url $url");

    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
    );

    if (response.statusCode == 200) {
      print(response.body.toString());

      final rechargelistModel = CommonRechargeModel.fromJson(
        json.decode(response.body),
      );

      return rechargelistModel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
