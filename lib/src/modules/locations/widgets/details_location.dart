import 'package:flutter/material.dart';

import '../../../../config/config.dart';

class DetailsLocation extends StatelessWidget {
  final String description;
  final String title;
  const DetailsLocation({
    Key? key,
    required this.description,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$title ',
          style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: AppThemeLight.titleDetail,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            description,
            maxLines: 1,
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: AppThemeLight.subTitleDescription,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
      ],
    );
  }
}
