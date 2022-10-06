import 'package:flutter/material.dart';

import '../home/widgets/widgets.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Locations List")),
    );
  }
}
