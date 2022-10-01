import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../config/config.dart';
import '../../../model/characters.dart';
import 'widgets/widgets.dart';

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
                    backgroundColor: Colors.black,
                    body: Container(
                        decoration: const BoxDecoration(),
                        child: SafeArea(
                            child: SingleChildScrollView(
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Center(
                              child: Image.asset(
                                'assets/images/logo.png',
                                height: 60,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: TextField(
                                onSubmitted: (valorInputSearch) {
                                  fetchFilterCharacters(valorInputSearch);
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  isDense: true,
                                  hintText: 'Search characters...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 14,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: CustomColors.containerColor,
                                    size: 25,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    icon: InkWell(
                                      onTap: () async {
                                        refreshPage();
                                      },
                                      child: const Icon(
                                        Icons.refresh,
                                        size: 25,
                                        color: CustomColors.containerColor,
                                      ),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(60),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                              ),
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
            backgroundColor: Colors.black,
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 60,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: TextField(
                    onSubmitted: (valorInputSearch) {
                      fetchFilterCharacters(valorInputSearch);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      hintText: 'Search characters...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: CustomColors.containerColor,
                        size: 25,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                        },
                        icon: InkWell(
                          onTap: () async {
                            refreshPage();
                          },
                          child: const Icon(
                            Icons.refresh,
                            size: 25,
                            color: CustomColors.containerColor,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
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
                              tagHero:
                                  futureCharacterFilter[index].id.toString(),
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
            )));
  }
}
