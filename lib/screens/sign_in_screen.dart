import 'package:busbooking/routes/routes.dart';
import 'package:busbooking/widgets/auth_textfield.dart';
import 'package:busbooking/widgets/custom_text.dart';
import 'package:busbooking/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';
import '../globalcontroller/languages_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final languagesController = Get.find<LanguagesController>();
  final signincController = Get.find<SignInController>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              SizedBox(height: screenHeight * 0.050),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 22),
                height: screenHeight * 0.35,
                width: screenWidth,
                decoration: BoxDecoration(
                  // color: Colors.red,
                  image: DecorationImage(
                    image: AssetImage("assets/images/signin.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.020),
              KText(
                textAlign: TextAlign.center,
                text: languagesController.tr("LOGIN"),
                fontWeight: FontWeight.bold,
                fontSize: screenHeight * 0.0250,
                color: Colors.grey.shade900,
              ),
              SizedBox(height: screenHeight * 0.003),
              KText(
                textAlign: TextAlign.center,
                text: languagesController.tr("PLEASE_ENTER_YOUR_INFORMATION"),
                fontWeight: FontWeight.w700,
                fontSize: screenHeight * 0.018,
                color: Colors.grey.shade500,
              ),
              SizedBox(height: screenHeight * 0.025),
              MyAuthTextfield(
                height: screenHeight * 0.070,
                hint: languagesController.tr("EMAIL_OR_PHONE"),
                controller: signincController.usernameController,
              ),
              SizedBox(height: screenHeight * 0.010),
              MyAuthTextfield(
                height: screenHeight * 0.070,
                hint: languagesController.tr("PASSWORD"),
                controller: signincController.passwordController,
              ),
              SizedBox(height: screenHeight * 0.0250),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KText(
                    text: languagesController.tr("FORGOT_PASSWORD"),
                    fontSize: screenHeight * 0.016,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(width: 5),
                  KText(
                    text: languagesController.tr("PASSWORD_RECOVERY"),
                    fontSize: screenHeight * 0.016,
                    color: Color(0xff1890FF),
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.030),

              DefaultButton(
                onTap: () {
                  signincController.signIn();
                },
                child: Obx(
                  () => KText(
                    text: signincController.isLoading.value == false
                        ? languagesController.tr("LOGIN")
                        : languagesController.tr("PLEASE_WAIT"),
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: screenHeight * 0.018,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.0250),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KText(
                    text: languagesController.tr("HAVENT_REGISTER_YET_?"),
                    fontSize: screenHeight * 0.016,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(width: 5),
                  KText(
                    text: languagesController.tr("REGISTER"),
                    fontSize: screenHeight * 0.016,
                    color: Color(0xff1890FF),
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
