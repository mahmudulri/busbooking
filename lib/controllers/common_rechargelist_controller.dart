import 'package:get/get.dart';

import '../models/common_recharge_model.dart';

import '../services/common_rechargelist_service.dart';

class CommonRechargelistController extends GetxController {
  int initialpage = 1;

  RxList<Item> finalList = <Item>[].obs;

  var isLoading = false.obs;

  var allrechargelist = CommonRechargeModel().obs;

  void fetchrechargelist() async {
    try {
      isLoading(true);
      await CommonrechagrlistApi().fetchlist().then((value) {
        allrechargelist.value = value;

        if (allrechargelist.value.body!.items != null) {
          finalList.addAll(allrechargelist.value.body!.items!);
        }

        isLoading(false);
      });

      isLoading(false);
    } catch (e) {
      print(e.toString());
    }
  }
}
