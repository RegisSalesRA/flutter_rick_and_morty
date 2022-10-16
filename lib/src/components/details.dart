import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../config/config.dart';
import '../../entity/characters.dart';
import '../../entity/episode.dart';

class DetailWidget extends StatefulWidget {
  final String tag;
  final String image;
  final String name;
  final String location;
  final String origin;
  final Gender gender;
  final String species;
  final Status status;
  final bool changeColor;
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
      required this.changeColor,
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
      backgroundColor: widget.changeColor
          ? AppThemeDark.backgroundColor
          : AppThemeLight.backgroundColor,
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                                decoration: BoxDecoration(
                                    color: widget.changeColor
                                        ? AppThemeDark.alive
                                        : AppThemeLight.alive,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100))),
                              ),
                            if (widget.status == Status.DEAD)
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: widget.changeColor
                                        ? AppThemeDark.dead
                                        : AppThemeLight.dead,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100))),
                              ),
                            if (widget.status == Status.UNKNOWN)
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: widget.changeColor
                                        ? AppThemeDark.unknow
                                        : AppThemeLight.unknow,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100))),
                              ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                widget.name,
                                style: TextStyle(
                                    color: widget.changeColor
                                        ? AppThemeDark.primaryColor
                                        : AppThemeLight.primaryColor,
                                    fontSize: AppTextStyle.titulo,
                                    fontWeight: FontWeight.bold),
                              ),
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
                              Text(
                                "Status: ",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: widget.changeColor
                                        ? AppThemeDark.titleDetail
                                        : AppThemeLight.titleDetail,
                                    fontSize: AppTextStyle.titulo,
                                    fontWeight: FontWeight.bold),
                              ),
                              if (widget.status == Status.ALIVE)
                                Text(
                                  "( ALIVE )",
                                  style: TextStyle(
                                      color: widget.changeColor
                                          ? AppThemeDark.alive
                                          : AppThemeLight.alive,
                                      fontSize: AppTextStyle.titulo,
                                      fontWeight: FontWeight.bold),
                                ),
                              if (widget.status == Status.DEAD)
                                Text(
                                  "( DEAD )",
                                  style: TextStyle(
                                      color: widget.changeColor
                                          ? AppThemeDark.dead
                                          : AppThemeLight.dead,
                                      fontSize: AppTextStyle.titulo,
                                      fontWeight: FontWeight.bold),
                                ),
                              if (widget.status == Status.UNKNOWN)
                                Text(
                                  "( UNKNOW )",
                                  style: TextStyle(
                                      color: widget.changeColor
                                          ? AppThemeDark.unknow
                                          : AppThemeLight.unknow,
                                      fontSize: AppTextStyle.titulo,
                                      fontWeight: FontWeight.bold),
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Origin: ",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: widget.changeColor
                                        ? AppThemeDark.titleDetail
                                        : AppThemeLight.titleDetail,
                                    fontSize: AppTextStyle.titulo,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: AnimatedFadedText(
                                  direction: 1,
                                  child: Text(
                                    widget.origin,
                                    maxLines: 1,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: widget.changeColor
                                            ? AppThemeDark.subTitleDescription
                                            : AppThemeLight.subTitleDescription,
                                        fontSize: AppTextStyle.titulo),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Location: ",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: widget.changeColor
                                        ? AppThemeDark.titleDetail
                                        : AppThemeLight.titleDetail,
                                    fontSize: AppTextStyle.titulo,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: AnimatedFadedText(
                                  direction: 1,
                                  child: Text(
                                    widget.location,
                                    maxLines: 1,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: widget.changeColor
                                            ? AppThemeDark.subTitleDescription
                                            : AppThemeLight.subTitleDescription,
                                        fontSize: AppTextStyle.titulo),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Gender: ",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: widget.changeColor
                                        ? AppThemeDark.titleDetail
                                        : AppThemeLight.titleDetail,
                                    fontSize: AppTextStyle.titulo,
                                    fontWeight: FontWeight.bold),
                              ),
                              if (widget.gender == Gender.MALE)
                                AnimatedFadedText(
                                  direction: 1,
                                  child: Text(
                                    'Male',
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 18,
                                      color: widget.changeColor
                                          ? AppThemeDark.subTitleDescription
                                          : AppThemeLight.subTitleDescription,
                                    ),
                                  ),
                                ),
                              if (widget.gender == Gender.FEMALE)
                                AnimatedFadedText(
                                  direction: 1,
                                  child: Text(
                                    'Female',
                                    style: TextStyle(
                                      fontSize: 18,
                                      overflow: TextOverflow.ellipsis,
                                      color: widget.changeColor
                                          ? AppThemeDark.subTitleDescription
                                          : AppThemeLight.subTitleDescription,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Species: ",
                                style: TextStyle(
                                    color: widget.changeColor
                                        ? AppThemeDark.titleDetail
                                        : AppThemeLight.titleDetail,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: AppTextStyle.titulo,
                                    fontWeight: FontWeight.bold),
                              ),
                              AnimatedFadedText(
                                direction: 1,
                                child: Text(
                                  widget.species,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: widget.changeColor
                                        ? AppThemeDark.subTitleDescription
                                        : AppThemeLight.subTitleDescription,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Nº Episodes: ",
                                style: TextStyle(
                                    color: widget.changeColor
                                        ? AppThemeDark.titleDetail
                                        : AppThemeLight.titleDetail,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: AppTextStyle.titulo,
                                    fontWeight: FontWeight.bold),
                              ),
                              AnimatedFadedText(
                                direction: 1,
                                child: Text(
                                  "${widget.episode.length}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: widget.changeColor
                                        ? AppThemeDark.subTitleDescription
                                        : AppThemeLight.subTitleDescription,
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
                            collapsedTextColor: widget.changeColor
                                ? AppThemeDark.primaryColor
                                : AppThemeLight.primaryColor,
                            collapsedIconColor: widget.changeColor
                                ? AppThemeDark.primaryColor
                                : AppThemeLight.primaryColor,
                            textColor: widget.changeColor
                                ? AppThemeDark.primaryColor
                                : AppThemeLight.primaryColor,
                            iconColor: widget.changeColor
                                ? AppThemeDark.primaryColor
                                : AppThemeLight.primaryColor,
                            tilePadding: const EdgeInsets.only(right: 20),
                            title: Text(
                              "Episodes",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: widget.changeColor
                                      ? AppThemeLight.backgroundColor
                                      : AppThemeLight.primaryColor),
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
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: widget.changeColor
                                                      ? AppThemeDark
                                                          .primaryColor
                                                      : AppThemeLight
                                                          .primaryColor),
                                            ),
                                            Text(
                                              episodesByCharactersList[index]
                                                  .airDate,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: widget.changeColor
                                                      ? AppThemeDark
                                                          .primaryColor
                                                      : AppThemeLight
                                                          .primaryColor),
                                            ),
                                            Text(
                                              episodesByCharactersList[index]
                                                  .episode,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: widget.changeColor
                                                      ? AppThemeDark
                                                          .primaryColor
                                                      : AppThemeLight
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
                icon: Icon(
                  Icons.arrow_back_rounded,
                  size: 30.0,
                  color: widget.changeColor
                      ? AppThemeDark.primaryColor
                      : AppThemeLight.primaryColor,
                )),
          )
        ],
      )),
    );
  }
}
