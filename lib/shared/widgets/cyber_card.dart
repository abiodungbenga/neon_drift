import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class CyberCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color borderColor;
  final double width;
  final double? height;

  const CyberCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20.0),
    this.borderColor = AppColors.neonPurple,
    this.width = double.infinity,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.glassBg,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: borderColor.withOpacity(0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.2),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}
