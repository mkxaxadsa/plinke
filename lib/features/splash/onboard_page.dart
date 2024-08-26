import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils.dart';
import '../../core/config/app_colors.dart';
import '../../core/widgets/buttons/primary_button.dart';
import '../../core/widgets/custom_scaffold.dart';
import '../../core/widgets/texts/text_b.dart';
import '../../core/widgets/texts/text_r.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  String text1 = 'Add educational institutions that suit you';
  String text2 =
      'Make a list of the universities you plan to apply to and write down key information about each one for yourself.';
  int id = 1;

  void onNext() async {
    if (id == 2) {
      await saveData().then((_) {
        context.go('/home');
      });
    } else {
      setState(() {
        text1 = 'Choose the facility that best meets your needs';
        text2 =
            'Consider the terms and conditions of each university and choose the one that suits you best.';
        id = 2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          children: [
            SizedBox(height: 64 + getStatusBar(context)),
            Center(
              child: TextB(
                text1,
                fontSize: 32,
                center: true,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 5,
              child: SvgPicture.asset('assets/o$id.svg'),
            ),
            const SizedBox(height: 20),
            TextR(
              text2,
              fontSize: 24,
              color: AppColors.text2,
              center: true,
            ),
            const Spacer(),
            PrimaryButton(
              title: 'Next',
              onPressed: onNext,
            ),
            const SizedBox(height: 40),
            CupertinoButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              minSize: 20,
              child: const TextR(
                'Terms of use  |  Privacy Policy',
                fontSize: 15,
                color: AppColors.text2,
              ),
            ),
            SizedBox(height: 18 + getBottom(context)),
          ],
        ),
      ),
    );
  }
}
