import 'package:flutter/material.dart';
import 'package:rick_and_morty/config/config.dart';
import 'package:rick_and_morty/src/modules/locations/widgets/earth_location_screen.dart';

import '../../components/components.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Header(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const EarthLocationScreen(heroTag: 'earth')));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Hero(
                          tag: 'earth',
                          child: Image.asset(
                            'assets/images/earth.png',
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Earth',
                          style: TextStyle(
                              color: AppThemeLight.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Planet",
                          style: TextStyle(
                            color: AppThemeLight.primaryColor,
                          ),
                        ),
                      ]),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Hero(
                          tag: 'cidatel',
                          child: Image.asset('assets/images/cidatel.png')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Cidatel of Ricks',
                          style: TextStyle(
                              color: AppThemeLight.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Space Stadium",
                          style: TextStyle(
                            color: AppThemeLight.primaryColor,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
