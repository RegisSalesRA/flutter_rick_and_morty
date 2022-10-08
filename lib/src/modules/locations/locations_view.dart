import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'widgets/widgets.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SafeArea(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Header(),
                  ChoiceLocation(
                    title: 'Earth',
                    label: 'Planet',
                    image: Image.asset(
                      'assets/images/earth.png',
                    ),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const EarthLocationScreen())),
                  ),
                  ChoiceLocation(
                    title: 'Cidatel of Ricks',
                    label: 'Space Stadium',
                    image: Image.asset('assets/images/cidatel.png'),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CidatelLocationScreen())),
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
