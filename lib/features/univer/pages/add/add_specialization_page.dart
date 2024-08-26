import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils.dart';
import '../../../../core/models/university.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../../../core/widgets/textfields/number_field.dart';
import '../../../../core/widgets/textfields/txt_field.dart';
import '../../../../core/widgets/texts/text_b.dart';
import '../../widgets/priority_card.dart';
import '../../widgets/field_title.dart';
import '../../bloc/univer_bloc.dart';

class AddSpecializationPage extends StatefulWidget {
  const AddSpecializationPage({super.key, required this.university});

  final University university;

  @override
  State<AddSpecializationPage> createState() => _AddSpecializationPageState();
}

class _AddSpecializationPageState extends State<AddSpecializationPage> {
  final controller1 = TextEditingController(); // specialization
  final controller2 = TextEditingController(); // priority
  final controller3 = TextEditingController(); // tuition fee
  final controller4 = TextEditingController(); // study year

  bool active = false;

  void checkActive() {
    setState(() {
      active = getButtonActive([
        controller1,
        controller2,
        controller3,
        controller4,
      ]);
    });
  }

  void onPriority(String priority) {
    controller2.text = priority;
    checkActive();
  }

  void onSave() {
    context.read<UniverBloc>().add(
          AddUniverEvent(
            university: University(
              id: widget.university.id,
              name: widget.university.name,
              location: widget.university.location,
              description: widget.university.description,
              rate: widget.university.rate,
              pros: widget.university.pros,
              cons: widget.university.cons,
              specialization: controller1.text,
              priority: controller2.text,
              tuition: int.tryParse(controller3.text) ?? 0,
              studyYears: int.tryParse(controller4.text) ?? 0,
            ),
          ),
        );
    context.pop();
    context.pop();
    context.pop();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
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
                      'New university',
                      fontSize: 32,
                      color: AppColors.yellow,
                    ),
                    const SizedBox(height: 50),
                    const FieldTitle('Name of the specialization'),
                    const SizedBox(height: 10),
                    TxtField(
                      controller: controller1,
                      onChanged: checkActive,
                    ),
                    const SizedBox(height: 20),
                    const FieldTitle('Priority'),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PriorityCard(
                          title: 'First',
                          active: controller2.text == 'First',
                          onPressed: onPriority,
                        ),
                        const SizedBox(width: 5),
                        PriorityCard(
                          title: 'Second',
                          active: controller2.text == 'Second',
                          onPressed: onPriority,
                        ),
                        const SizedBox(width: 5),
                        PriorityCard(
                          title: 'Third',
                          active: controller2.text == 'Third',
                          onPressed: onPriority,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const FieldTitle('Tuition fees'),
                    const SizedBox(height: 10),
                    NumberField(
                      controller: controller3,
                      onChanged: checkActive,
                    ),
                    const SizedBox(height: 20),
                    const FieldTitle('Years of study'),
                    const SizedBox(height: 10),
                    NumberField(
                      controller: controller4,
                      length: 2,
                      onChanged: checkActive,
                    ),
                    SizedBox(height: 150 + getBottom(context)),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 77 + getBottom(context)),
                    child: PrimaryButton(
                      title: 'Save',
                      active: active,
                      onPressed: onSave,
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
