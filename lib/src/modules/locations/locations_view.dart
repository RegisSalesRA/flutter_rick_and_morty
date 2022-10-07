import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/modules/locations/widgets/earth_location_screen.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          children: [
            InkWell(
              child: const Text("Earth"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EarthLocationScreen()));
              },
            ),
            const Text("Cidatel")
          ],
        )),
      ),
    );
  }
}
