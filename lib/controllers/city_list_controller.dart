import 'package:busbooking/models/city_list_model.dart';
import 'package:busbooking/models/wallet_model.dart';
import 'package:busbooking/services/city_list_service.dart';
import 'package:busbooking/services/wallet_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/customer_profile_service.dart';
import 'search_bus_controller.dart';

final searchBusController = Get.find<SearchBusController>();

class CityListController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  /// API থেকে আসা সব city
  RxList<Item> allCities = <Item>[].obs;

  /// Search অনুযায়ী filtered city
  RxList<Item> filteredCities = <Item>[].obs;

  /// Selected city info
  RxnInt selectedCityId = RxnInt();
  RxString selectedCityName = ''.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllCities();
    searchController.addListener(_onSearchChanged);
  }

  void fetchAllCities() async {
    try {
      isLoading(true);

      final response = await CityListApi().fetchCityData();
      final items = response.body?.items ?? [];

      allCities.assignAll(items);
      filteredCities.assignAll(items);
    } catch (e) {
      debugPrint("City fetch error: $e");
    } finally {
      isLoading(false);
    }
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();

    if (query.isEmpty) {
      filteredCities.assignAll(allCities);
    } else {
      filteredCities.assignAll(
        allCities.where(
          (city) => city.name?.toLowerCase().contains(query) ?? false,
        ),
      );
    }
  }

  /// Call this when city is tapped
  void selectoriginCity(Item city) {
    selectedCityId.value = city.id;
    selectedCityName.value = city.name ?? '';

    // searchBusController.originCityId = selectedCityId.value.toString();
    // searchBusController.originCityName.value = selectedCityName.value
    //     .toString();
  }

  void selectdestinationCity(Item city) {
    selectedCityId.value = city.id;
    selectedCityName.value = city.name ?? '';
    // searchBusController.destinationCityId = selectedCityId.value.toString();
    // searchBusController.destinationCityName = selectedCityName.value.toString();
  }

  void clearSearch() {
    searchController.clear();
    filteredCities.assignAll(allCities);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
