import 'dart:io';

import 'package:flutter/material.dart';
import '../../../config/config.dart';
import '../../components/components.dart';
import 'screens/screens.dart';
import 'widgets/widgets.dart';

class LocationScreen extends StatefulWidget {
  final bool changeColor;
  const LocationScreen({Key? key, required this.changeColor}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

 bool internetEnabled = false;

void internetCheck()async{
  try {
  final result = await InternetAddress.lookup('google.com');
  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    setState(() {
      internetEnabled = true;
    });
  }
} on SocketException catch (_) {
  print('not connected');
}
}

  @override
  void initState() {
    internetCheck();
    super.initState();      }



  @override
  Widget build(BuildContext context) {
    if(internetEnabled){
     return  Material(
      child: Scaffold(
        backgroundColor:
            widget.changeColor ? AppThemeDark.backgroundColor : Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Header(changeColor: widget.changeColor),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ChoiceLocation(
                    changeColor: widget.changeColor,
                    title: 'Earth',
                    label: 'Planet',
                    image: Image.asset(
                      'assets/images/earth.png',
                    ),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EarthLocationScreen(
                              changeColor: widget.changeColor,
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ChoiceLocation(
                    changeColor: widget.changeColor,
                    title: 'Cidatel of Ricks',
                    label: 'Space Stadium',
                    image: Image.asset('assets/images/cidatel.png'),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CidatelLocationScreen(
                              changeColor: widget.changeColor,
                            ))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    } else {
      return const ErrorConnection();
    }
  }
}
