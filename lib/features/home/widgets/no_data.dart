import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/widgets/texts/text_r.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/circle.svg'),
              const SizedBox(width: 5),
              const TextR('Not university yet', fontSize: 24),
            ],
          ),
          const SizedBox(height: 11),
          const TextR(
            'Add the first university',
            fontSize: 16,
            color: AppColors.text2,
          ),
        ],
      ),
    );
  }
}
