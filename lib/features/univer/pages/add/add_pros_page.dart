import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils.dart';
import '../../../../core/models/university.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../../../core/widgets/textfields/txt_field.dart';
import '../../../../core/widgets/texts/text_b.dart';
import '../../widgets/field_title.dart';

class AddProsPage extends StatefulWidget {
  const AddProsPage({super.key, required this.university});

  final University university;

  @override
  State<AddProsPage> createState() => _AddProsPageState();
}

class _AddProsPageState extends State<AddProsPage> {
  List<TextEditingController> controllers1 = [TextEditingController()]; // pros
  List<TextEditingController> controllers2 = [TextEditingController()]; // cons

  bool active = false;

  void checkActive() {
    setState(() {
      active = getButtonActive([
        ...controllers1,
        ...controllers2,
      ]);
    });
  }

  void onRemove1() {
    controllers1.removeLast();
    checkActive();
  }

  void onRemove2() {
    controllers2.removeLast();
    checkActive();
  }

  void onMore1() {
    controllers1.add(TextEditingController());
    checkActive();
  }

  void onMore2() {
    controllers2.add(TextEditingController());
    checkActive();
  }

  void onRemove() {
    controllers2.removeLast();
    checkActive();
  }

  void onContinue() {
    context.push(
      '/add3',
      extra: University(
        id: widget.university.id,
        name: widget.university.name,
        location: widget.university.location,
        description: widget.university.description,
        rate: widget.university.rate,
        pros: [
          for (TextEditingController controller in controllers1) ...[
            controller.text
          ],
        ],
        cons: [
          for (TextEditingController controller in controllers2) ...[
            controller.text
          ],
        ],
        specialization: '',
        priority: '',
        tuition: 0,
        studyYears: 0,
      ),
    );
  }

  @override
  void dispose() {
    for (TextEditingController controller in controllers1) {
      controller.dispose();
    }
    for (TextEditingController controller in controllers2) {
      controller.dispose();
    }
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
                      center: true,
                    ),
                    const SizedBox(height: 50),
                    FieldTitle(
                      'Pros',
                      onMore: onMore1,
                      onRemove: controllers1.length >= 2 ? onRemove1 : null,
                    ),
                    const SizedBox(height: 10),
                    ...List.generate(
                      controllers1.length,
                      (index) {
                        return Column(
                          children: [
                            TxtField(
                              controller: controllers1[index],
                              onChanged: checkActive,
                            ),
                            if (controllers1.length > 1)
                              const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    FieldTitle(
                      'Cons',
                      onMore: onMore2,
                      onRemove: controllers2.length >= 2 ? onRemove2 : null,
                    ),
                    const SizedBox(height: 10),
                    ...List.generate(
                      controllers2.length,
                      (index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onLongPress: onRemove,
                              child: TxtField(
                                controller: controllers2[index],
                                onChanged: checkActive,
                              ),
                            ),
                            if (controllers2.length > 1)
                              const SizedBox(height: 10),
                          ],
                        );
                      },
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
