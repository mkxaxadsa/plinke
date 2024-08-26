import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/widgets/texts/text_r.dart';

class RateCard extends StatelessWidget {
  const RateCard({
    super.key,
    required this.rate,
    required this.onPressed,
  });

  final int rate;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const TextR(
            'Rating of university reviews',
            fontSize: 20,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _StarButton(
                id: 1,
                active: rate >= 1,
                onPressed: onPressed,
              ),
              const SizedBox(width: 5),
              _StarButton(
                id: 2,
                active: rate >= 2,
                onPressed: onPressed,
              ),
              const SizedBox(width: 5),
              _StarButton(
                id: 3,
                active: rate >= 3,
                onPressed: onPressed,
              ),
              const SizedBox(width: 5),
              _StarButton(
                id: 4,
                active: rate >= 4,
                onPressed: onPressed,
              ),
              const SizedBox(width: 5),
              _StarButton(
                id: 5,
                active: rate >= 5,
                onPressed: onPressed,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _StarButton extends StatelessWidget {
  const _StarButton({
    required this.id,
    required this.active,
    required this.onPressed,
  });

  final int id;
  final bool active;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        onPressed(id);
      },
      padding: EdgeInsets.zero,
      minSize: 22,
      child: SvgPicture.asset(active ? 'assets/star1.svg' : 'assets/star2.svg'),
    );
  }
}
