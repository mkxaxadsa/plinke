import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            'assets/bg.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SvgPicture.asset('assets/bg.svg'),
          ),
          body,
        ],
      ),
    );
  }
}
