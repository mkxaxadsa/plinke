import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/models/university.dart';
import '../../../core/widgets/texts/text_r.dart';

class UniverCard extends StatelessWidget {
  const UniverCard({super.key, required this.university});

  final University university;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: CupertinoButton(
        onPressed: () {
          context.push('/detail', extra: university);
        },
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                TextR(university.name, fontSize: 24),
                const SizedBox(height: 10),
                TextR(
                  university.location,
                  fontSize: 16,
                  color: AppColors.text2,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      university.rate >= 1
                          ? 'assets/star1.svg'
                          : 'assets/star2.svg',
                    ),
                    const SizedBox(width: 5),
                    SvgPicture.asset(
                      university.rate >= 2
                          ? 'assets/star1.svg'
                          : 'assets/star2.svg',
                    ),
                    const SizedBox(width: 5),
                    SvgPicture.asset(
                      university.rate >= 3
                          ? 'assets/star1.svg'
                          : 'assets/star2.svg',
                    ),
                    const SizedBox(width: 5),
                    SvgPicture.asset(
                      university.rate >= 4
                          ? 'assets/star1.svg'
                          : 'assets/star2.svg',
                    ),
                    const SizedBox(width: 5),
                    SvgPicture.asset(
                      university.rate >= 5
                          ? 'assets/star1.svg'
                          : 'assets/star2.svg',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
            const Positioned(
              right: 16,
              top: 0,
              bottom: 0,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
