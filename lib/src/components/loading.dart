import 'package:flutter/material.dart';

import '../../config/config.dart';

class LoadingWidgetScrollView extends StatelessWidget {
  final ValueNotifier<bool> isLoading;
  final bool changeColor;

  const LoadingWidgetScrollView(
      {Key? key, required this.isLoading, required this.changeColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isLoading,
        builder: (context, bool isLoading, _) {
          return (isLoading)
              ? Positioned(
                  left: (MediaQuery.of(context).size.width / 2) - 20,
                  bottom: 20,
                  child: CircleAvatar(
                    backgroundColor: changeColor
                        ? AppThemeDark.primaryColor
                        : AppThemeLight.primaryColor,
                    child: const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  ))
              : Container();
        });
  }
}
