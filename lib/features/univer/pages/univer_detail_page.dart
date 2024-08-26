import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:univer_test/features/univer/widgets/field_title.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/models/university.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/texts/text_b.dart';
import '../../../core/widgets/texts/text_r.dart';

class UniverDetailPage extends StatelessWidget {
  const UniverDetailPage({super.key, required this.university});

  final University university;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          CustomAppbar(university: university),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(height: 20),
                const TextB(
                  'University',
                  fontSize: 32,
                  color: AppColors.yellow,
                  center: true,
                ),
                const SizedBox(height: 50),
                _NameCard(university),
                const SizedBox(height: 20),
                const FieldTitle('Pros'),
                const SizedBox(height: 10),
                ...List.generate(
                  university.pros.length,
                  (index) {
                    return _Card(university.pros[index]);
                  },
                ),
                const SizedBox(height: 10),
                const FieldTitle('Cons'),
                const SizedBox(height: 10),
                ...List.generate(
                  university.cons.length,
                  (index) {
                    return _Card(university.cons[index]);
                  },
                ),
                const SizedBox(height: 10),
                const FieldTitle('Specialties'),
                const SizedBox(height: 10),
                _Card(
                  university.specialization,
                  title2: university.priority,
                ),
                _Card(
                  'Tuition fee',
                  title2: '\$${university.tuition}',
                ),
                const SizedBox(height: 74),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NameCard extends StatelessWidget {
  const _NameCard(this.university);

  final University university;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/circle.svg'),
                  const SizedBox(width: 5),
                  TextR(university.name, fontSize: 24),
                ],
              ),
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
    );
  }
}

class _Card extends StatelessWidget {
  const _Card(this.title, {this.title2 = ''});

  final String title;
  final String title2;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const SizedBox(width: 60),
          Expanded(
            child: Center(
              child: TextR(title, fontSize: 20),
            ),
          ),
          if (title2.isNotEmpty)
            TextR(
              title2,
              fontSize: 16,
              color: AppColors.text2,
            ),
          SizedBox(width: title2.isEmpty ? 60 : 20),
        ],
      ),
    );
  }
}
