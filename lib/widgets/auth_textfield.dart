import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../globalcontroller/font_controller.dart';

class AuthTextfield extends StatelessWidget {
  final TextEditingController controller;

  final String hint;
  final Color? backgroundColor;
  final double height;
  final double borderRadius;
  final TextInputType keyboardType;

  AuthTextfield({
    Key? key,
    required this.controller,

    required this.hint,
    this.backgroundColor,
    this.height = 55,
    this.borderRadius = 12,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      color: backgroundColor ?? Colors.white,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: TextStyle(
            fontFamily: box.read("language").toString() == "Fa"
                ? Get.find<FontController>().currentFont
                : null,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          isDense: false,
          contentPadding: EdgeInsets.symmetric(
            vertical: box.read("direction") == "rtl" ? 12 : 20,
            horizontal: 12,
          ),
        ),
      ),
    );
  }
}

class MyAuthTextfield extends StatelessWidget {
  final TextEditingController controller;

  final String hint;
  final Color? backgroundColor;
  final Color? borderColor;
  final double height;
  final double borderRadius;
  final TextInputType keyboardType;
  MyAuthTextfield({
    super.key,
    required this.controller,
    this.borderColor,
    required this.hint,
    this.backgroundColor,
    this.height = 55,
    this.borderRadius = 12,
    this.keyboardType = TextInputType.text,
  });

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        border: Border.all(
          width: 1,
          color: borderColor ?? Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: box.read("direction") == "rtl" ? 12 : 20,
              horizontal: 12,
            ),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: box.read("language").toString() == "Fa"
                  ? Get.find<FontController>().currentFont
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
