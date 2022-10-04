import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    return FutureBuilder<List<Result>>(
      future: futureCharacterList,
      builder: (context, snapshot) {
        if (snapshot.hasData && !snapshot.hasError) {
          List<Result>? data = snapshot.data;
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Header(),
                SearchBar(
                    controller: searchController,
                    onFilter: (value) {
                      setState(() {
                        searchString = value.toLowerCase().toString();
                      });
                    },
                    onSubmitted: (valorInputSearch) async {
                      await fetchFilterCharacters(valorInputSearch);
                      limparControlers();
                      setState(() {
                        searchString = '';
                      });
                      FocusScope.of(context).unfocus();
                    },
                    onTapFilter: () async {
                      await fetchFilterCharacters(searchString);
                      limparControlers();
                      setState(() {
                        searchString = '';
                      });
                      FocusScope.of(context).unfocus();
                    },
                    onTap: () async {
                      refreshPage();
                      limparControlers();
                      setState(() {
                        searchString = '';
                      });
                      FocusScope.of(context).unfocus();
                    }),
                if (futureCharacterFilter.isEmpty) ...[
                  if (searchString.isNotEmpty)
                    ListViewCard(data: data, searchString: searchString),
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
          );
        }
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
