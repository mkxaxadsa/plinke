import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils.dart';
import '../../../core/config/app_colors.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/texts/text_b.dart';
import '../../univer/bloc/univer_bloc.dart';
import '../widgets/univer_card.dart';
import '../widgets/no_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              const CustomAppbar(home: true),
              BlocBuilder<UniverBloc, UniverState>(
                builder: (context, state) {
                  if (state is UniverLoadedState) {
                    if (state.univers.isEmpty) return const NoData();

                    return Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 44),
                        children: [
                          const SizedBox(height: 20),
                          const TextB(
                            'Your education',
                            fontSize: 32,
                            color: AppColors.yellow,
                            center: true,
                          ),
                          const SizedBox(height: 50),
                          ...List.generate(
                            state.univers.length,
                            (index) {
                              return UniverCard(
                                university: state.univers[index],
                              );
                            },
                          ),
                          SizedBox(height: 150 + getBottom(context)),
                        ],
                      ),
                    );
                  }

                  return Container();
                },
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 77 + getBottom(context)),
              child: PrimaryButton(
                title: 'Add new university',
                onPressed: () {
                  context.push('/add1');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
