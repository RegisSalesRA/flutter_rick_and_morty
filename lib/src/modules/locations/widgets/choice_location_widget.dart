import 'package:flutter/material.dart';

import '../../../../config/config.dart';

class ChoiceLocation extends StatelessWidget {
  final String title;
  final String label;
  final VoidCallback? onTap;
  final Image image;
  const ChoiceLocation({
    Key? key,
    required this.title,
    required this.label,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: image,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: const TextStyle(
                  color: AppThemeLight.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: const TextStyle(
                color: AppThemeLight.primaryColor,
              ),
            ),
          ]),
        )
      ],
    );
  }
}
