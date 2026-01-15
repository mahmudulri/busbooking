import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LanguagesController extends GetxController {
  RxString selectedlan = "En".obs;

  RxMap<String, String> currentlanguage = <String, String>{}.obs;

  List<Map<String, String>> alllanguagedata = [
    {
      "name": "En",
      "fullname": "Eng",
      "isoCode": "en",
      "region": "US",
      "direction": "ltr",
      "imagelink": "assets/icons/usaflag.png",
    },
    {
      "name": "Fa",
      "fullname": "فارسی",
      "isoCode": "fa",
      "region": "IR",
      "direction": "rtl",
      "imagelink": "assets/icons/iranflag.png",
    },
    {
      "name": "Ps",
      "fullname": "پښتو",
      "isoCode": "ps",
      "region": "AF",
      "direction": "rtl",
      "imagelink": "assets/icons/afghanflag.png",
    },
    {
      "name": "Bn",
      "fullname": "বাংলা",
      "isoCode": "bn",
      "region": "BD",
      "direction": "ltr",
      "imagelink": "assets/icons/bdflag.png",
    },
    // {
    //   "name": "Ar",
    //   "fullname": "العربية",
    //   "isoCode": "ar",
    //   "region": "AE",
    //   "direction": "rtl",
    //   "imagelink": "",
    // },
    // {
    //   "name": "Tr",
    //   "fullname": "Türkçe",
    //   "isoCode": "tr",
    //   "region": "TR",
    //   "direction": "ltr",
    //   "imagelink": "",
    // },
  ];

  @override
  void onInit() {
    super.onInit();
    changeLanguage("En");
  }

  /// Load JSON file using full locale: e.g., "fa-IR.json"
  Future<void> loadLanguageByLocale(String isoCode, String regionCode) async {
    final localeKey = "$isoCode-$regionCode";
    try {
      print("📂 Loading JSON: assets/langs/$localeKey.json");
      String jsonString = await rootBundle.loadString(
        "assets/langs/$localeKey.json",
      );
      Map<String, dynamic> jsonData = json.decode(jsonString);

      currentlanguage.clear();
      currentlanguage.addAll(
        jsonData.map((key, value) => MapEntry(key, value.toString())),
      );
    } catch (e) {
      print("❌ Error loading language file: $e");
    }
  }

  String getCurrentFlag() {
    final lang = alllanguagedata.firstWhere(
      (e) => e["name"] == selectedlan.value,
      orElse: () => {"imagelink": "assets/icons/iranflag.png"},
    );

    return lang["imagelink"] ?? "assets/icons/iranflag.png";
  }

  /// Change language by internal "name" key (e.g., "Fa", "En")
  void changeLanguage(String languageShortName) {
    print("🔄 Changing Language to: $languageShortName");
    selectedlan.value = languageShortName;

    final matchedLang = alllanguagedata.firstWhere(
      (lang) => lang["name"] == languageShortName,
      orElse: () => {
        "isoCode": "en",
        "region": "US",
        "imagelink": "assets/icons/iranflag.png",
      },
    );

    final iso = matchedLang["isoCode"]!;
    final region = matchedLang["region"]!;

    /// ✅ ensure imagelink default
    matchedLang["imagelink"] ??= "assets/icons/iranflag.png";
    loadLanguageByLocale(iso, region);
  }

  /// Translate a key
  String tr(String key) {
    return currentlanguage[key] ?? key;
  }
}
