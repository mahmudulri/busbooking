import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/transaction_model.dart';
import '../utils/api_endpoints.dart';

class CustomerTranstionApi {
  final box = GetStorage();
  Future<TransactionsModel> fetchlist() async {
    final url = Uri.parse(
      ApiEndPoints.baseUrl + ApiEndPoints.otherendpoints.customertransactions,
    );
    print("url $url");

    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${box.read("userToken")}'},
    );

    if (response.statusCode == 200) {
      // print(response.body.toString());

      final transactionModel = TransactionsModel.fromJson(
        json.decode(response.body),
      );

      return transactionModel;
    } else {
      throw Exception('Failed to fetch gateway');
    }
  }
}
