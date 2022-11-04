import 'package:flutter/material.dart';
import '../../../config/config.dart';
import '../../components/components.dart';
import 'screens/screens.dart';
import 'widgets/widgets.dart';

class LocationScreen extends StatelessWidget {
  final bool changeColor;
  const LocationScreen({Key? key, required this.changeColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor:
            changeColor ? AppThemeDark.backgroundColor : Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Header(changeColor: changeColor),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ChoiceLocation(
                    changeColor: changeColor,
                    title: 'Earth',
                    label: 'Planet',
                    image: Image.asset(
                      'assets/images/earth.png',
                    ),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EarthLocationScreen(
                              changeColor: changeColor,
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ChoiceLocation(
                    changeColor: changeColor,
                    title: 'Cidatel of Ricks',
                    label: 'Space Stadium',
                    image: Image.asset('assets/images/cidatel.png'),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CidatelLocationScreen(
                              changeColor: changeColor,
                            ))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
