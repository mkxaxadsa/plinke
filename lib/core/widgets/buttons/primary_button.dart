import 'package:flutter/cupertino.dart';

import '../../config/app_colors.dart';
import '../texts/text_r.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    this.active = true,
    required this.onPressed,
  });

  final String title;
  final bool active;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 225,
      decoration: BoxDecoration(
        color: active ? AppColors.main : AppColors.main.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CupertinoButton(
        onPressed: active ? onPressed : null,
        padding: EdgeInsets.zero,
        child: Center(
          child: TextR(
            title,
            fontSize: 16,
            color: active ? AppColors.white : AppColors.white.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
