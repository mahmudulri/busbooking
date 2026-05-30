import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final double height;
  final BorderRadius borderRadius;

  const PrimaryButton({
    super.key,
    required this.onTap,
    this.title = "Add New",
    this.height = 48,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: Container(
        height: height,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: const LinearGradient(
            colors: [
              Color(0xFF8B0010), // dark red
              Color(0xFF5F0015), // maroon (your design)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: Colors.white),
            const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
