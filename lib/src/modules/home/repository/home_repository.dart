import 'package:flutter/cupertino.dart';

import '../../../../model/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RepositoryHomeImp extends ChangeNotifier {
  String searchString = "";
  List<Result> futureCharacterFilterImp = [];
  late Future<List<Result>> futureCharacterList;
  late List<Result> futureCharacterFilter = [];
  bool isLoading = false;

  Future<List<Result>> fetchCharacters() async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var jsonResponseList = jsonResponse["results"] as List;

      return jsonResponseList.map((data) => Result.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load character');
    }
  }

  fetchFilterCharacters(String nameValue, List lista) async {
    if (searchString.isEmpty || searchString == "") {}

    lista.clear();

    final response = await http.get(Uri.parse(
        "https://rickandmortyapi.com/api/character/?name=$nameValue"));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var jsonResponseList = jsonResponse["results"] as List;

      for (Result item
          in jsonResponseList.map((data) => Result.fromJson(data)).toList()) {
        lista.add(item);
      }
      return lista;
    } else {
      throw Exception('Failed to load character');
    }
  }
}
