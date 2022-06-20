import 'package:flutter/material.dart';
import 'package:rick_and_morty/css/animated/animated_fade_transiction.dart';
import 'package:rick_and_morty/css/colors.dart';
import 'package:rick_and_morty/css/text.dart';
import 'package:rick_and_morty/widgets/appBar.dart';

void gotoDetailsPage(BuildContext context, image, tag, nome, location, origin,
    gender, species, status) {
  Navigator.of(context).push(MaterialPageRoute<void>(
    builder: (BuildContext context) => Scaffold(
      appBar: MyAppBar(
        title: nome,
        actionsAppBar: Row(children: [
          InkWell(
            onTap: () {},
            child: const Padding(
                padding: EdgeInsets.all(5), child: Icon(Icons.filter_alt)),
          ),
          const SizedBox(
            width: 8,
          )
        ]),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/enviroments/background_pages.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: Center(
                    child: Column(children: [
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: CustomColors.containerColor,
                            width: 10.0,
                            style: BorderStyle.solid),
                      ),
                      child: Hero(
                          tag: tag,
                          child: Image.network(
                            image,
                            fit: BoxFit.fitWidth,
                          ))),
                ])),
              ),
              SizedBox(
                height: 190,
                width: 325,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        "Detalhes",
                        style: TextStyle(
                            color: CustomColors.title,
                            fontSize: CustomText.bold,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Origin: ",
                          style: TextStyle(
                              color: CustomColors.title,
                              fontSize: CustomText.regular,
                              fontWeight: FontWeight.bold),
                        ),
                        AnimatedFadedText(
                          direction: 1,
                          child: Text(
                            origin.toString(),
                            style: const TextStyle(
                              color: CustomColors.title,
                              fontSize: CustomText.regular,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Location: ",
                          style: TextStyle(
                              color: CustomColors.title,
                              fontSize: CustomText.regular,
                              fontWeight: FontWeight.bold),
                        ),
                        AnimatedFadedText(
                          direction: 1,
                          child: Text(
                            location.toString(),
                            style: const TextStyle(
                                color: CustomColors.title,
                                fontSize: CustomText.regular),
                          ),
                        ),
                      ],
                    ),
                    AnimatedFadedText(
                      direction: 1,
                      child: Text(
                        gender.toString(),
                        style: const TextStyle(
                            color: CustomColors.title,
                            fontSize: CustomText.regular),
                      ),
                    ),
                    AnimatedFadedText(
                      direction: 1,
                      child: Text(
                        species.toString(),
                        style: const TextStyle(
                            color: CustomColors.title,
                            fontSize: CustomText.regular),
                      ),
                    ),
                    AnimatedFadedText(
                      direction: 1,
                      child: Text(
                        status.toString(),
                        style: const TextStyle(
                            color: CustomColors.title,
                            fontSize: CustomText.regular),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    ),
  ));
}
