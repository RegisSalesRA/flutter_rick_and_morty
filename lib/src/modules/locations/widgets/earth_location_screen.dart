import 'package:flutter/material.dart';

import '../../../../config/config.dart';

class EarthLocationScreen extends StatefulWidget {
  const EarthLocationScreen({Key? key}) : super(key: key);

  @override
  State<EarthLocationScreen> createState() => _EarthLocationScreenState();
}

class _EarthLocationScreenState extends State<EarthLocationScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
                height: size.height * 0.40,
                child: Hero(
                    tag: 'widget.tag',
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50)),
                      child: Image.asset(
                        'assets/images/earth.png',
                        fit: BoxFit.fill,
                      ),
                    ))),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Earth",
                style: TextStyle(
                    color: AppThemeLight.primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 150,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                        style: BorderStyle.solid)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          "Type: ",
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.pink,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: AnimatedFadedText(
                            direction: 1,
                            child: Text(
                              'Planet',
                              maxLines: 1,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.lightGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Text(
                          "First Episode: ",
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.pink,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: AnimatedFadedText(
                            direction: 1,
                            child: Text(
                              'Pilot',
                              maxLines: 1,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.lightGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "Dimension: ",
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.pink,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: AnimatedFadedText(
                            direction: 1,
                            child: Text(
                              'Dimension C-137',
                              maxLines: 1,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.lightGreen,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Residents: ",
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ]),
        ),
        Positioned(
            top: 20,
            left: 20,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.pink,
              ),
            ))
      ],
    )));
  }
}
