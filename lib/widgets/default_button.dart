import 'package:busbooking/utils/colors.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  const DefaultButton({
    super.key,
    this.height,
    this.width,
    required this.child,
    this.backgroundColor = AppColors.primaryColor,
    this.borderColor = Colors.transparent,
    this.borderWidth = 1,
    this.borderRadius = 8,
    this.onTap,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(width: borderWidth, color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(child: child),
      ),
    );
  }
}
