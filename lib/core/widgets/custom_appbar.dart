import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/univer/bloc/univer_bloc.dart';
import '../config/app_colors.dart';
import '../models/university.dart';
import '../utils.dart';
import 'dialogs/delete_dialog.dart';
import 'texts/text_r.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    this.home = false,
    this.university,
  });

  final bool home;
  final University? university;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: getStatusBar(context)),
          Row(
            children: [
              if (home)
                CupertinoButton(
                  onPressed: () {
                    context.push('/settings');
                  },
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  minSize: 20,
                  child: const TextR('Settings', fontSize: 16),
                )
              else
                CupertinoButton(
                  onPressed: () {
                    context.pop();
                  },
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  minSize: 20,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppColors.white,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      TextR('Back', fontSize: 16),
                    ],
                  ),
                ),
              if (university != null) ...[
                const Spacer(),
                CupertinoButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DeleteDialog(
                          title: 'Delete?',
                          onYes: () {
                            try {
                              context
                                  .read<UniverBloc>()
                                  .add(DeleteUniverEvent(id: university!.id));
                              context.pop();
                            } catch (_) {}
                          },
                        );
                      },
                    );
                  },
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  minSize: 20,
                  child: const TextR('Delete', fontSize: 16),
                ),
                CupertinoButton(
                  onPressed: () {
                    context.push('/edit1', extra: university);
                  },
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  minSize: 20,
                  child: const TextR('Edit', fontSize: 16),
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }
}
