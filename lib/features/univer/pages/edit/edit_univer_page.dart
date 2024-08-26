import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/university.dart';
import '../../../../core/utils.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../../../core/widgets/textfields/txt_field.dart';
import '../../../../core/widgets/texts/text_b.dart';
import '../../widgets/field_title.dart';
import '../../widgets/rate_card.dart';

class EditUniverPage extends StatefulWidget {
  const EditUniverPage({super.key, required this.university});

  final University university;

  @override
  State<EditUniverPage> createState() => _EditUniverPageState();
}

class _EditUniverPageState extends State<EditUniverPage> {
  final controller1 = TextEditingController(); // name
  final controller2 = TextEditingController(); // location
  final controller3 = TextEditingController(); // description

  bool active = true;
  int rate = 0;

  void checkActive() {
    if (rate >= 1) {
      setState(() {
        active = getButtonActive([
          controller1,
          controller2,
          controller3,
        ]);
      });
    }
  }

  void onRate(int id) {
    rate = id;
    checkActive();
  }

  void onContinue() {
    context.push(
      '/edit2',
      extra: University(
        id: widget.university.id,
        name: controller1.text,
        location: controller2.text,
        description: controller3.text,
        rate: rate,
        pros: widget.university.pros,
        cons: widget.university.cons,
        specialization: widget.university.specialization,
        priority: widget.university.priority,
        tuition: widget.university.tuition,
        studyYears: widget.university.studyYears,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller1.text = widget.university.name;
    controller2.text = widget.university.location;
    controller3.text = widget.university.description;
    rate = widget.university.rate;
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const CustomAppbar(),
          Expanded(
            child: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    const SizedBox(height: 20),
                    const TextB(
                      'Edit university',
                      fontSize: 32,
                      color: AppColors.yellow,
                    ),
                    const SizedBox(height: 50),
                    const FieldTitle('University name'),
                    const SizedBox(height: 10),
                    TxtField(
                      controller: controller1,
                      onChanged: checkActive,
                    ),
                    const SizedBox(height: 20),
                    const FieldTitle('University location'),
                    const SizedBox(height: 10),
                    TxtField(
                      controller: controller2,
                      onChanged: checkActive,
                    ),
                    const SizedBox(height: 20),
                    const FieldTitle('Description of the University'),
                    const SizedBox(height: 10),
                    TxtField(
                      controller: controller3,
                      onChanged: checkActive,
                    ),
                    const SizedBox(height: 48),
                    RateCard(
                      rate: rate,
                      onPressed: onRate,
                    ),
                    SizedBox(height: 150 + getBottom(context)),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 77 + getBottom(context)),
                    child: PrimaryButton(
                      title: 'Continue',
                      active: active,
                      onPressed: onContinue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
