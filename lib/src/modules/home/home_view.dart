import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../config/config.dart';
import '../../../model/model.dart';
import 'widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Result>> futureCharacterList;
  final searchController = TextEditingController();
  List<Result> futureCharacterFilter = [];
  String searchString = "";
  bool isLoading = false;

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
    if (searchString.isEmpty || searchString == "") {}

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
        setState(() {
          futureCharacterFilter.add(item);
        });
      }

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

  void limparControlers() {
    searchController.clear();
  }

  void loadingPage() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    futureCharacterList = fetchCharacters(1);
    refreshPage();
  }

  @override
  void dispose() {
    super.dispose();
    searchController;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder<List<Result>>(
        future: futureCharacterList,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.waiting:
              return SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Header(),
                    const SearchBar(
                        onSubmitted: null,
                        onTapFilter: null,
                        onTap: null,
                        onFilter: null,
                        controller: null),
                    const SizedBox(
                      height: 20,
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 10 / 11.5,
                      children: List.generate(
                        10,
                        (index) => CustomShimmer(
                          height: size.height,
                          width: size.width,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                  ],
                ),
              ));
            case ConnectionState.done:
              if (snapshot.hasData && !snapshot.hasError) {
                List<Result>? data = snapshot.data;
                return SafeArea(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          const Header(),
                          SearchBar(
                              controller: searchController,
                              onFilter: (value) {
                                setState(() {
                                  searchString = value.toLowerCase().toString();
                                });
                              },
                              onSubmitted: (valorInputSearch) async {
                                loadingPage();
                                await fetchFilterCharacters(valorInputSearch);
                                limparControlers();
                                setState(() {
                                  searchString = '';
                                });
                                FocusScope.of(context).unfocus();
                              },
                              onTapFilter: () async {
                                loadingPage();
                                await fetchFilterCharacters(searchString);
                                limparControlers();
                                setState(() {
                                  searchString = '';
                                });
                                FocusScope.of(context).unfocus();
                              },
                              onTap: () async {
                                loadingPage();
                                refreshPage();
                                limparControlers();
                                setState(() {
                                  searchString = '';
                                });
                                FocusScope.of(context).unfocus();
                              }),
                          if (futureCharacterFilter.isEmpty) ...[
                            if (searchString.isNotEmpty)
                              ListViewCard(
                                  data: data, searchString: searchString),
                            if (searchString.isEmpty || searchString == '')
                              GridCard(
                                listItens: data!,
                              ),
                          ] else if (futureCharacterFilter.isNotEmpty) ...[
                            if (searchString.isNotEmpty)
                              ListViewCard(
                                  data: futureCharacterFilter,
                                  searchString: searchString),
                            if (searchString.isEmpty || searchString == '')
                              GridCard(
                                listItens: futureCharacterFilter,
                              ),
                          ],
                        ]),
                      ),
                      isLoading
                          ? Container(
                              color: Colors.black.withOpacity(0.5),
                              width: size.width,
                              height: size.height,
                              child: const Center(
                                  child: CupertinoActivityIndicator(
                                radius: 25,
                                color: primaryColor,
                              )))
                          : Container()
                    ],
                  ),
                );
              } else {
                return SafeArea(
                    child: SingleChildScrollView(
                        child: Column(children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Header(),
                  Image.asset(
                    'assets/images/error.png',
                    height: 350,
                  ),
                  const Text(
                    "Error connection",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(25),
                    child: const Text(
                      "Please check your internet connection or try again later!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ])));
              }
          }
          return Container();
        });
  }
}
