import 'package:flutter/material.dart';
import '../../../../config/config.dart';

void gotoDetailsPage(BuildContext context, image, tag, nome, location, origin,
    gender, species, status) {
  Navigator.of(context).push(MaterialPageRoute<void>(
    builder: (BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        elevation: 0.0,
        actions: null,
      ),
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(color: Colors.black),
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
              Container(
                decoration: const BoxDecoration(color: Colors.black),
                height: 200,
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
                            fontSize: CustomText.titulo,
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
                              fontSize: CustomText.titulo,
                              fontWeight: FontWeight.bold),
                        ),
                        AnimatedFadedText(
                          direction: 1,
                          child: Text(
                            origin.toString(),
                            style: const TextStyle(
                              color: CustomColors.title,
                              fontSize: CustomText.titulo,
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
                              fontSize: CustomText.titulo,
                              fontWeight: FontWeight.bold),
                        ),
                        AnimatedFadedText(
                          direction: 1,
                          child: Text(
                            location.toString(),
                            style: const TextStyle(
                                color: CustomColors.title,
                                fontSize: CustomText.titulo),
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
                            fontSize: CustomText.titulo),
                      ),
                    ),
                    AnimatedFadedText(
                      direction: 1,
                      child: Text(
                        species.toString(),
                        style: const TextStyle(
                            color: CustomColors.title,
                            fontSize: CustomText.titulo),
                      ),
                    ),
                    AnimatedFadedText(
                      direction: 1,
                      child: Text(
                        status.toString(),
                        style: const TextStyle(
                            color: CustomColors.title,
                            fontSize: CustomText.titulo),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    ),
  ));
}
