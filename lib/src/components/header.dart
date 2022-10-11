import 'package:flutter/material.dart';
import 'package:rick_and_morty/config/theme_color.dart';

class Header extends StatelessWidget {
  final bool changeColor;
  const Header({Key? key, required this.changeColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 60,
          color: changeColor
              ? AppThemeDark.primaryColor
              : AppThemeLight.primaryColor,
        ),
      ),
    );
  }
}
