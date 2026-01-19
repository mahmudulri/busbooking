import 'package:get/get.dart';

import '../models/customer_profile_model.dart';
import '../services/customer_profile_service.dart';

class CustomerProfileController extends GetxController {
  // @override
  // void onInit() {
  //   fetchProfile();
  //   super.onInit();
  // }

  var isLoading = false.obs;

  var alldashboardData = CustomerProfileModel().obs;

  void fetchProfile() async {
    try {
      isLoading(true);
      await CustomerProfileApi().fetchProfile().then((value) {
        alldashboardData.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
