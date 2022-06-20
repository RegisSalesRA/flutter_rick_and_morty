// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:rick_and_morty/css/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  Widget? actionsAppBar;

  MyAppBar({Key? key, required this.title, this.actionsAppBar})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title!,
        style: const TextStyle(
          color: CustomColors.title,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: [actionsAppBar!],
    );
  }
}
