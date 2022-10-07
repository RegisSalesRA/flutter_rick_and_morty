import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../config/config.dart';
import '../../../../model/characters.dart';
import '../../../../model/episode.dart';

class DetailWidget extends StatefulWidget {
  final String tag;
  final String image;
  final String name;
  final String location;
  final String origin;
  final Gender gender;
  final Species species;
  final Status status;
  final List<String> episode;

  const DetailWidget(
      {Key? key,
      required this.tag,
      required this.image,
      required this.name,
      required this.location,
      required this.origin,
      required this.gender,
      required this.species,
      required this.status,
      required this.episode})
      : super(key: key);

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  var episodesByCharactersList = [];

  fetchEpisodesByCharacters(list) async {
    for (var item in widget.episode) {
      final response = await http.get(Uri.parse(item));
      var value = Episode.fromJson(jsonDecode(response.body));
      if (!mounted) return;
      setState(() {
        episodesByCharactersList.add(value);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchEpisodesByCharacters(widget.episode);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    height: 350,
                    width: double.infinity,
                    child: Hero(
                        tag: widget.tag,
                        child: Image.network(
                          widget.image,
                          fit: BoxFit.fitWidth,
                        ))),
                Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child:

                            // TITULO STATUS
                            Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.status == Status.ALIVE)
                              Container(
                                height: 10,
                                width: 10,
                                decoration: const BoxDecoration(
                                    color: AppThemeLight.alive,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                              ),
                            if (widget.status == Status.DEAD)
                              Container(
                                height: 10,
                                width: 10,
                                decoration: const BoxDecoration(
                                    color: AppThemeLight.dead,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                              ),
                            if (widget.status == Status.UNKNOWN)
                              Container(
                                height: 10,
                                width: 10,
                                decoration: const BoxDecoration(
                                    color: AppThemeLight.unknow,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                              ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                widget.name,
                                style: const TextStyle(
                                    color: AppThemeLight.primaryColor,
                                    fontSize: AppTextStyle.titulo,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            if (widget.status == Status.ALIVE)
                              const Text(
                                "( ALIVE )",
                                style: TextStyle(
                                    color: AppThemeLight.alive,
                                    fontSize: AppTextStyle.titulo,
                                    fontWeight: FontWeight.bold),
                              ),
                            if (widget.status == Status.DEAD)
                              const Text(
                                "( DEAD )",
                                style: TextStyle(
                                    color: AppThemeLight.dead,
                                    fontSize: AppTextStyle.titulo,
                                    fontWeight: FontWeight.bold),
                              ),
                            if (widget.status == Status.UNKNOWN)
                              const Text(
                                "( UNKNOW )",
                                style: TextStyle(
                                    color: AppThemeLight.unknow,
                                    fontSize: AppTextStyle.titulo,
                                    fontWeight: FontWeight.bold),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: size.width * 0.95,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                              color: Colors.grey.shade300,
                              width: 2,
                              style: BorderStyle.solid)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Origin: ",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: AppThemeLight.titleDetail,
                                    fontSize: AppTextStyle.titulo,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: AnimatedFadedText(
                                  direction: 1,
                                  child: Text(
                                    widget.origin,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color:
                                            AppThemeLight.subTitleDescription,
                                        fontSize: AppTextStyle.titulo),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Location: ",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: AppThemeLight.titleDetail,
                                    fontSize: AppTextStyle.titulo,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: AnimatedFadedText(
                                  direction: 1,
                                  child: Text(
                                    widget.location,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color:
                                            AppThemeLight.subTitleDescription,
                                        fontSize: AppTextStyle.titulo),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Gender: ",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: AppThemeLight.titleDetail,
                                    fontSize: AppTextStyle.titulo,
                                    fontWeight: FontWeight.bold),
                              ),
                              if (widget.gender == Gender.MALE)
                                const AnimatedFadedText(
                                  direction: 1,
                                  child: Text(
                                    'Male',
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: AppThemeLight.subTitleDescription,
                                    ),
                                  ),
                                ),
                              if (widget.gender == Gender.FEMALE)
                                const AnimatedFadedText(
                                  direction: 1,
                                  child: Text(
                                    'Female',
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: AppThemeLight.subTitleDescription,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Species: ",
                                style: TextStyle(
                                    color: AppThemeLight.titleDetail,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: AppTextStyle.titulo,
                                    fontWeight: FontWeight.bold),
                              ),
                              if (widget.species == Species.HUMAN)
                                const AnimatedFadedText(
                                  direction: 1,
                                  child: Text(
                                    'Human',
                                    style: TextStyle(
                                      color: AppThemeLight.subTitleDescription,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              if (widget.species == Species.ALIEN)
                                const AnimatedFadedText(
                                  direction: 1,
                                  child: Text(
                                    'Alien',
                                    style: TextStyle(
                                      color: AppThemeLight.subTitleDescription,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Nº Episodes: ",
                                style: TextStyle(
                                    color: AppThemeLight.titleDetail,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: AppTextStyle.titulo,
                                    fontWeight: FontWeight.bold),
                              ),
                              AnimatedFadedText(
                                direction: 1,
                                child: Text(
                                  "${widget.episode.length}",
                                  style: const TextStyle(
                                    color: AppThemeLight.subTitleDescription,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ExpansionTile(
                            textColor: AppThemeLight.primaryColor,
                            iconColor: AppThemeLight.primaryColor,
                            tilePadding: const EdgeInsets.only(right: 20),
                            title: const Text(
                              "Episodes",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [
                              episodesByCharactersList.isEmpty
                                  ? const Text("Sem episodios")
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          episodesByCharactersList.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Text(
                                              episodesByCharactersList[index]
                                                  .name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppThemeLight
                                                      .primaryColor),
                                            ),
                                            Text(
                                              episodesByCharactersList[index]
                                                  .airDate,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppThemeLight
                                                      .primaryColor),
                                            ),
                                            Text(
                                              episodesByCharactersList[index]
                                                  .episode,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppThemeLight
                                                      .primaryColor),
                                            ),
                                            Divider(
                                              thickness: 2,
                                              color: Colors.grey.shade200,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: 30.0,
                  color: AppThemeLight.primaryColor,
                )),
          )
        ],
      )),
    );
  }
}
