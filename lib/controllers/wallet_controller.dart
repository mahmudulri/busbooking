import 'package:busbooking/models/wallet_model.dart';
import 'package:busbooking/services/wallet_service.dart';
import 'package:get/get.dart';
import '../services/customer_profile_service.dart';

class WalletController extends GetxController {
  // @override
  // void onInit() {
  //   fetchProfile();
  //   super.onInit();
  // }

  var isLoading = false.obs;

  var wallet = WalletModel().obs;

  void fetchWallet() async {
    try {
      isLoading(true);
      await WalletApi().fetchwallet().then((value) {
        wallet.value = value;

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
