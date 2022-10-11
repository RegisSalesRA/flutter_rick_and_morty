import 'package:flutter/material.dart';
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
        backgroundColor: changeColor ? Colors.black : Colors.white,
        body: SafeArea(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Header(changeColor: changeColor),
                  ChoiceLocation(
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
                  ChoiceLocation(
                    changeColor: changeColor,
                    title: 'Cidatel of Ricks',
                    label: 'Space Stadium',
                    image: Image.asset('assets/images/cidatel.png'),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CidatelLocationScreen(
                              changeColor: changeColor,
                            ))),
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
