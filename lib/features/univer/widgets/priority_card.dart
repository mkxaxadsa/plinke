import 'package:flutter/cupertino.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/widgets/texts/text_r.dart';

class PriorityCard extends StatelessWidget {
  const PriorityCard({
    super.key,
    required this.title,
    required this.active,
    required this.onPressed,
  });

  final String title;
  final bool active;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CupertinoButton(
        onPressed: () {
          onPressed(title);
        },
        padding: EdgeInsets.zero,
        child: Container(
          height: 60,
          width: 114,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(30),
            border: active
                ? Border.all(
                    color: AppColors.yellow,
                    width: 2,
                  )
                : null,
          ),
          child: Center(
            child: TextR(
              title,
              fontSize: 20,
              color: active ? AppColors.yellow : AppColors.text1,
            ),
          ),
        ),
      ),
    );
  }
}
