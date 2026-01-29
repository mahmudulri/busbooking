import 'dart:convert';

import 'package:busbooking/models/wallet_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/customer_profile_model.dart';

import '../utils/api_endpoints.dart';

class WalletApi {
  final box = GetStorage();
  Future<WalletModel> fetchwallet() async {
    final url = Uri.parse(
      ApiEndPoints.baseUrl + ApiEndPoints.otherendpoints.customerwallet,
    );

    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
    );

    if (response.statusCode == 200) {
      // print(response.statusCode.toString());
      // print(response.body.toString());
      final dashboardModel = WalletModel.fromJson(json.decode(response.body));

      return dashboardModel;
    } else {
      var results = jsonDecode(response.body);
      Fluttertoast.showToast(
        msg: "${results["errors"]}\n${results["message"]}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      throw Exception('Failed to fetch gateway');
    }
  }
}
