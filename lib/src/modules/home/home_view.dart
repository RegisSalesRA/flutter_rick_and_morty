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
  final serachController = TextEditingController();
  List<Result> futureCharacterFilter = [];
  List<String> listaStringFilter = ["Joao", "Julio", "Sales", "Rengel", "Zamb"];
  String searchString = "";
  String popularEvents = 'All';

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
    if (serachController.text.isEmpty || serachController.text == "") {}

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

  @override
  void initState() {
    super.initState();
    futureCharacterList = fetchCharacters(1);
    refreshPage();
  }

  void limparControlers() {
    serachController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    serachController;
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
                    controller: serachController,
                    onFilter: (value) {
                      setState(() {
                        searchString = value.toLowerCase().toString();
                      });
                    },
                    onSubmitted: (valorInputSearch) {
                      fetchFilterCharacters(valorInputSearch);
                    },
                    onTapFilter: () async {
                      fetchFilterCharacters(serachController.text);
                    },
                    onTap: () async {
                      refreshPage();
                      limparControlers();
                      setState(() {
                        searchString = '';
                      });
                    }),
                if (searchString.isNotEmpty)
                  futureCharacterFilter.isEmpty
                      ? ListViewCard(data: data, searchString: searchString)
                      : GridCard(
                          listItens: futureCharacterFilter,
                        ),
                if (searchString.isEmpty)
                  futureCharacterFilter.isEmpty
                      ? GridCard(
                          listItens: data!,
                        )
                      : GridCard(
                          listItens: futureCharacterFilter,
                        ),
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
