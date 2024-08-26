import 'package:flutter/material.dart';

import '../../config/app_colors.dart';

class TextM extends StatelessWidget {
  const TextM(
    this.title, {
    super.key,
    required this.fontSize,
    this.color = AppColors.text1,
    this.center = false,
  });

  final String title;
  final double fontSize;
  final Color color;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: center ? TextAlign.center : null,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: Fonts.medium,
      ),
    );
  }
}
