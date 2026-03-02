import 'package:busbooking/controllers/sign_in_controller.dart';
import 'package:busbooking/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/customer_profile_controller.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  CustomerProfileController controller = Get.put(CustomerProfileController());

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.black.withOpacity(0.9),
      height: screenHeight,
      width: screenWidth - 80,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 60),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Center(child: Icon(Icons.person, size: 30)),
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(
                      text:
                          controller.profileData.value.body!.profile!.firstName
                              .toString() +
                          " " +
                          controller.profileData.value.body!.profile!.lastName
                              .toString(),
                      color: Colors.white,
                    ),
                    KText(
                      text: controller.profileData.value.body!.profile!.email
                          .toString(),
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 60),
            ProfileMenuBox(
              menuName: languagesController.tr("PROFILE"),
              imglink: "assets/icons/profile11.png",
            ),

            ProfileMenuBox(
              menuName: languagesController.tr("TERMS_AND_CONDITIONS"),
              imglink: "assets/icons/terms11.png",
            ),
            ProfileMenuBox(
              menuName: languagesController.tr("FAQ"),
              imglink: "assets/icons/faq11.png",
            ),
            ProfileMenuBox(
              menuName: languagesController.tr("HELP"),
              imglink: "assets/icons/help11.png",
            ),
            ProfileMenuBox(
              menuName: languagesController.tr("CONTACT_US"),
              imglink: "assets/icons/whatsapp11.png",
            ),
            ProfileMenuBox(
              menuName: languagesController.tr("LANGUAGES"),
              imglink: "assets/icons/global11.png",
              onpressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(languagesController.tr("LANGUAGES")),
                      content: SizedBox(
                        height: 350,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: languagesController.alllanguagedata.length,
                          itemBuilder: (context, index) {
                            final data =
                                languagesController.alllanguagedata[index];

                            return GestureDetector(
                              onTap: () {
                                final languageName = data["name"].toString();

                                final matched = languagesController
                                    .alllanguagedata
                                    .firstWhere(
                                      (lang) => lang["name"] == languageName,
                                      orElse: () => {
                                        "isoCode": "en",
                                        "direction": "ltr",
                                      },
                                    );

                                final languageISO = matched["isoCode"]!;
                                final languageDirection = matched["direction"]!;

                                // Save & apply
                                languagesController.changeLanguage(
                                  languageName,
                                );
                                box.write("language", languageName);
                                box.write("direction", languageDirection);

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
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
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
            ),
            Spacer(),
            ProfileMenuBox(
              menuName: languagesController.tr("LOG_OUT"),
              imglink: "assets/icons/logout11.png",
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuBox extends StatelessWidget {
  ProfileMenuBox({super.key, this.menuName, this.imglink, this.onpressed});

  String? menuName;
  String? imglink;
  VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onpressed,

      child: Container(
        margin: EdgeInsets.only(top: 5),
        height: 50,
        width: screenWidth,
        child: Row(
          children: [
            Image.asset(imglink.toString(), height: 40),
            SizedBox(width: 5),
            KText(
              text: menuName.toString(),
              color: Color(0xffEEF4FF),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
