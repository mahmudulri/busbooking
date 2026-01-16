import 'package:busbooking/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../globalcontroller/languages_controller.dart';

class Homeservicebox extends StatelessWidget {
  final String? btnName;
  final String? imglink;
  final String? isActive;
  final VoidCallback? onpressed;

  Homeservicebox({
    super.key,
    this.btnName,
    this.imglink,
    this.isActive,
    this.onpressed,
  });

  final languagesController = Get.find<LanguagesController>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        height: screenWidth * 0.300,
        width: screenWidth * 0.180,
        child: Column(
          children: [
            Container(
              height: screenWidth * 0.180,
              width: screenWidth * 0.180,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: isActive.toString() != "yes"
                      ? Colors.grey.shade200
                      : Colors.white,
                ),
                borderRadius: BorderRadius.circular(10),
                color: isActive.toString() == "yes"
                    ? Color(0xffF4F6F8)
                    : Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Image.asset(imglink.toString()),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  KText(
                    textAlign: TextAlign.center,
                    text: btnName.toString(),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff454F5B),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
