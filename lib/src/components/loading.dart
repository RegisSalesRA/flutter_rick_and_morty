import 'package:flutter/material.dart';

class LoadingWidgetScrollView extends StatelessWidget {
  final ValueNotifier<bool> isLoading;

  const LoadingWidgetScrollView({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isLoading,
        builder: (context, bool isLoading, _) {
          return (isLoading)
              ? Positioned(
                  left: (MediaQuery.of(context).size.width / 2) - 20,
                  bottom: 20,
                  child: const CircleAvatar(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  ))
              : Container();
        });
  }
}
