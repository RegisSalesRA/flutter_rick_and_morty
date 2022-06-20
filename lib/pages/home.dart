import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/pages/details.dart';
import 'package:rick_and_morty/widgets/appBar.dart';
import 'package:rick_and_morty/widgets/character.dart';

import '../model/characters.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Result>> futureCharacterList;
  final _serachController = TextEditingController();
  List<Result> futureCharacterFilter = [];
  int initialPage = 1;

  Future<List<Result>> fetchCharacters(pageNumber) async {
    final response = await http.get(Uri.parse(
        'https://rickandmortyapi.com/api/character/?page=${pageNumber.toString()}'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var jsonResponseList = jsonResponse["results"] as List;

      return jsonResponseList.map((data) => Result.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load character');
    }
  }

  Future<List<Result>> fetchFilterCharacters(nameValue) async {
    if (_serachController.text.isEmpty || _serachController.text == "") {
      print("");
    }

    setState(() {
      futureCharacterFilter = [];
    });

    final response = await http.get(Uri.parse(
        "https://rickandmortyapi.com/api/character/?name=$nameValue"));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var jsonResponseList = jsonResponse["results"] as List;

      for (Result item
          in jsonResponseList.map((data) => Result.fromJson(data)).toList()) {
        print(item.name);
        setState(() {
          futureCharacterFilter.add(item);
        });
      }
      print(futureCharacterFilter.length);
      return futureCharacterFilter;
    } else {
      throw Exception('Failed to load character');
    }
  }

  openModalSheetBottom() async {
    await showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 180,
              width: 12.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0)),
                color: const Color(0xFF000000).withOpacity(0.8),
              ));
        });
  }

  void refreshPage() {
    setState(() {
      futureCharacterFilter.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    futureCharacterList = fetchCharacters(1);
    //  futureCharacterFilter = fetchFilterCharacters(value);
  }

  @override
  void dispose() {
    super.dispose();
    _serachController;
  }

  @override
  Widget build(BuildContext context) {
    return futureCharacterFilter.isEmpty
        ? FutureBuilder<List<Result>>(
            future: futureCharacterList,
            builder: (context, snapshot) {
              if (snapshot.hasData && !snapshot.hasError) {
                List<Result>? data = snapshot.data;
                return Scaffold(
                    appBar: MyAppBar(
                      title: "Home",
                      actionsAppBar: Row(children: [
                        InkWell(
                          onTap: () async {
                            refreshPage();
                            /*
                            await fetchCharacters(1);
                            setState(() {
                              futureCharacterList =
                                  fetchCharacters(initialPage++);
                            });

                            */
                          },
                          child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.refresh)),
                        ),
                        InkWell(
                          onTap: openModalSheetBottom,
                          child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.filter_alt)),
                        ),
                        const SizedBox(
                          width: 8,
                        )
                      ]),
                    ),
                    extendBodyBehindAppBar: true,
                    backgroundColor: Colors.black,
                    body: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/enviroments/background_pages.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: SafeArea(
                            child: SingleChildScrollView(
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                  controller: _serachController,
                                  style: const TextStyle(color: Colors.black),
                                  onSubmitted: (valorInputSearch) {
                                    fetchFilterCharacters(valorInputSearch);
                                  },
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Colors.black),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                    hintText: 'Search for characters',
                                    prefixIcon: Icon(
                                      Icons.search,
                                      size: 30.0,
                                    ),
                                  )),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(10),
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: data!.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 250,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 10.0,
                                    ),
                                    itemBuilder:
                                        ((BuildContext context, int index) {
                                      return InkWell(
                                        child: ChracterWidget(
                                          name: data[index].name,
                                          image: data[index].image,
                                          tagHero: data[index].id.toString(),
                                        ),
                                        onTap: () => {
                                          gotoDetailsPage(
                                            context,
                                            data[index].image,
                                            data[index].id.toString(),
                                            data[index].name,
                                            data[index].location.name,
                                            data[index].origin.name,
                                            data[index].gender,
                                            data[index].species,
                                            data[index].status,
                                          )
                                        },
                                      );
                                    })))
                          ]),
                        ))));
              }
              return const Center(child: CircularProgressIndicator());
            },
          )
        : Scaffold(
            appBar: MyAppBar(
              title: "Home",
              actionsAppBar: Row(children: [
                InkWell(
                  onTap: () {
                    refreshPage();
                  },
                  child: const Padding(
                      padding: EdgeInsets.all(5), child: Icon(Icons.refresh)),
                ),
                InkWell(
                  onTap: openModalSheetBottom,
                  child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.filter_alt)),
                ),
                const SizedBox(
                  width: 8,
                )
              ]),
            ),
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.black,
            body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage("assets/enviroments/background_pages.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                    child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                          controller: _serachController,
                          style: const TextStyle(color: Colors.black),
                          onSubmitted: (valorInputSearch) {
                            fetchFilterCharacters(valorInputSearch);
                          },
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.black),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            hintText: 'Search for characters',
                            prefixIcon: Icon(
                              Icons.search,
                              size: 30.0,
                            ),
                          )),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: futureCharacterFilter.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 250,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            itemBuilder: ((BuildContext context, int index) {
                              return InkWell(
                                child: ChracterWidget(
                                  name: futureCharacterFilter[index].name,
                                  image: futureCharacterFilter[index].image,
                                  tagHero: futureCharacterFilter[index]
                                      .id
                                      .toString(),
                                ),
                                onTap: () => {
                                  gotoDetailsPage(
                                    context,
                                    futureCharacterFilter[index].image,
                                    futureCharacterFilter[index].id.toString(),
                                    futureCharacterFilter[index].name,
                                    futureCharacterFilter[index].location.name,
                                    futureCharacterFilter[index].origin.name,
                                    futureCharacterFilter[index].gender,
                                    futureCharacterFilter[index].species,
                                    futureCharacterFilter[index].status,
                                  )
                                },
                              );
                            })))
                  ]),
                ))));
  }
}
