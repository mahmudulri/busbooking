import 'dart:convert';
import 'package:busbooking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:busbooking/utils/api_endpoints.dart';

import '../globalcontroller/languages_controller.dart';

final languagesController = Get.find<LanguagesController>();

class SignInController extends GetxController {
  final box = GetStorage();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool loginsuccess = false.obs;

  Future<void> signIn() async {
    try {
      isLoading.value = true;
      loginsuccess.value = true;
      print(loginsuccess.value);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.otherendpoints.signin,
      );
      print("API URL: $url");

      // Map body = {
      //   'username': usernameController.text,
      //   'password': passwordController.text,
      // };

      Map body = {'email_or_mobile': "ab@gmail.com", 'password': "1234560"};

      print("Request Body: $body");

      http.Response response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );

      final results = jsonDecode(response.body);
      // print("Response Status Code: ${response.statusCode}");
      // print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        box.write("userToken", results["body"]["token"]);

        if (results["success"] == true) {
          // dashboardController.fetchDashboardData();

          loginsuccess.value = false;
          print(loginsuccess.value);

          Get.snackbar(
            results["status"],
            languagesController.tr("LOG_IN_SUCCESSFULL"),
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.primaryColor,
            colorText: Colors.white,
            margin: const EdgeInsets.all(16),
            borderRadius: 12,
            icon: const Icon(Icons.check_circle, color: Colors.white),
            duration: const Duration(seconds: 2),
          );
        } else {
          Get.snackbar(
            results["message"],
            results["errors"],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          results["message"],
          results["errors"],
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Error during sign in: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
