import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:univer_test/core/widgets/texts/text_r.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/texts/text_b.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: Column(
        children: [
          CustomAppbar(),
          SizedBox(height: 20),
          TextB(
            'Settings',
            fontSize: 32,
            color: AppColors.yellow,
          ),
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                _SettingsTile(
                  id: 1,
                  title: 'Terms of use',
                  url:
                      'https://docs.google.com/document/d/15_W8FqFU-2N2wb2IFlHaL15tc5KZnzPdhSfgwug4lic/edit?usp=sharing',
                ),
                SizedBox(height: 30),
                _SettingsTile(
                  id: 2,
                  title: 'Privacy Policy',
                  url:
                      'https://docs.google.com/document/d/1tVYS_xSwg3rtnLb-ifR5YVOGMQMULMiu82707bnh35w/edit?usp=sharing',
                ),
                SizedBox(height: 30),
                _SettingsTile(
                  id: 3,
                  title: 'Support page',
                  url: 'https://forms.gle/rNbfaYmtca462vb86',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.id,
    required this.title,
    required this.url,
  });

  final int id;
  final String title;
  final String url;

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: CupertinoButton(
        onPressed: _launchUrl,
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            const SizedBox(width: 50),
            const Spacer(),
            SvgPicture.asset('assets/s$id.svg'),
            const SizedBox(width: 7),
            TextR(title, fontSize: 20),
            const Spacer(),
            const SizedBox(
              width: 50,
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
