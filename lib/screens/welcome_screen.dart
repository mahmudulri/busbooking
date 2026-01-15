import 'package:busbooking/routes/routes.dart';
import 'package:busbooking/utils/colors.dart';
import 'package:busbooking/widgets/default_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../globalcontroller/languages_controller.dart';
import '../models/slogan_model.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<SloganModel> slogans = [
    SloganModel(
      title: "مدیریت مالی (دبیت و کریدیت پول)",
      description:
          "این اپلیکیشن امکان واریز و برداشت پول را برای کاربران فراهم می‌کند. کاربران می‌توانند کیف پول دیجیتال خود را شارژ کنند، مبالغ موردنیاز را انتقال دهند و تراکنش‌های مالی خود را مشاهده و مدیریت کنند.",
    ),
    SloganModel(
      title: " پرداخت آسان – مدیریت مالی بی‌دردسر",
      description:
          "با پرداخت آسان تراکنش‌های مالی خود را به ساده‌ترین شکل انجام دهید. امکان واریز، برداشت و انتقال پول را داشته باشید.",
    ),
    SloganModel(
      title: "کیف پول سریع – پرداخت‌های مطمئن و فوری",
      description:
          "کیف پول سریع راهی هوشمند و ایمن برای مدیریت پول شما است. موجودی کیف پول خود را افزایش دهید، مبلغ موردنظر را انتقال دهید.",
    ),
    SloganModel(
      title: "جریان نقدی – مرکز مالی شخصی شما",
      description:
          "با جریان نقدی، کنترل کامل امور مالی خود را در دست بگیرید. کیف پول دیجیتال خود را شارژ کنید، پرداخت‌های خود را به‌آسانی انجام دهید و تمامی معاملات مالی خود را در یک مکان مدیریت نمایید.",
    ),
  ];

  final languagesController = Get.find<LanguagesController>();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenHeight * 0.40,
              width: screenWidth,
              // color: Colors.red,
              child: Stack(
                children: [
                  Container(
                    height: screenHeight * 0.40,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/welcome.png"),
                      ),
                    ),
                  ),
                  // Container(height: 40, width: 80, color: Colors.cyan),
                  Positioned(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(6),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  languagesController.tr("LANGUAGES"),
                                ),
                                content: SizedBox(
                                  height: 350,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: languagesController
                                        .alllanguagedata
                                        .length,
                                    itemBuilder: (context, index) {
                                      final data = languagesController
                                          .alllanguagedata[index];

                                      return GestureDetector(
                                        onTap: () {
                                          final languageName = data["name"]
                                              .toString();

                                          final matched = languagesController
                                              .alllanguagedata
                                              .firstWhere(
                                                (lang) =>
                                                    lang["name"] ==
                                                    languageName,
                                                orElse: () => {
                                                  "isoCode": "en",
                                                  "direction": "ltr",
                                                },
                                              );

                                          final languageISO =
                                              matched["isoCode"]!;
                                          final languageDirection =
                                              matched["direction"]!;

                                          // Save & apply
                                          languagesController.changeLanguage(
                                            languageName,
                                          );
                                          box.write("language", languageName);
                                          box.write(
                                            "direction",
                                            languageDirection,
                                          );

                                          // Map iso → Locale
                                          Locale locale;
                                          switch (languageISO) {
                                            case "fa":
                                              locale = const Locale("fa", "IR");
                                              break;
                                            case "ar":
                                              locale = const Locale("ar", "AE");
                                              break;
                                            case "ps":
                                              locale = const Locale("ps", "AF");
                                              break;
                                            case "tr":
                                              locale = const Locale("tr", "TR");
                                              break;
                                            case "bn":
                                              locale = const Locale("bn", "BD");
                                              break;
                                            case "en":
                                            default:
                                              locale = const Locale("en", "US");
                                          }

                                          setState(() {
                                            EasyLocalization.of(
                                              context,
                                            )!.setLocale(locale);
                                          });

                                          Navigator.pop(context);
                                          debugPrint(
                                            "🌐 Language: $languageName ($languageISO), dir: $languageDirection",
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 5),
                                          height: 45,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            data["fullname"].toString(),
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 70,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// 🔹 Language short name
                              // Obx(
                              //   () => Text(
                              //     languagesController.selectedlan.value,
                              //     style: const TextStyle(
                              //       color: Colors.white,
                              //       fontWeight: FontWeight.w600,
                              //       fontSize: 14,
                              //     ),
                              //   ),
                              // ),
                              Icon(
                                FontAwesomeIcons.chevronDown,
                                color: Colors.white,
                                size: 18,
                              ),

                              /// 🔹 Flag image instead of icon
                              Obx(() {
                                final lang = languagesController.alllanguagedata
                                    .firstWhere(
                                      (e) =>
                                          e["name"] ==
                                          languagesController.selectedlan.value,
                                      orElse: () => {
                                        "imagelink":
                                            "assets/icons/iranflag.png",
                                      },
                                    );

                                return ClipOval(
                                  child: Image.asset(
                                    lang["imagelink"] ??
                                        "assets/icons/iranflag.png",
                                    width: 24,
                                    height: 24,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.010),

            Container(
              height: screenHeight * 0.26,
              width: screenWidth,
              // color: Colors.blue,
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: _pageController,
                itemCount: slogans.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        slogans[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenHeight * 0.022,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        slogans[index].description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenHeight * 0.020,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            Container(
              height: screenHeight * 0.02,
              width: screenWidth,
              // color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  slogans.length,
                  (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: currentIndex == index ? 8 : 8,
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ? Color(0xff7BC9FF)
                          : Colors.black26,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.010),

            Row(
              children: [
                Expanded(
                  child: DefaultButton(
                    height: screenHeight * 0.062,
                    child: Text(
                      languagesController.tr("LOGIN"),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.040,
                      ),
                    ),
                    onTap: () {
                      Get.toNamed(signinscreen);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DefaultButton(
                    height: screenHeight * 0.062,
                    backgroundColor: Colors.white,
                    borderColor: AppColors.primaryColor,
                    child: Text(
                      languagesController.tr("REGISTER"),
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.040,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
