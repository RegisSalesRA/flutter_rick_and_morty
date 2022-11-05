import 'package:flutter/cupertino.dart';

import '../../../../entity/entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RepositoryHomeImp extends ChangeNotifier {
  String searchString = "";
  List<Result> futureCharacterFilterImp = [];
  List<Result> futureCharacterListScrollView = [];
  late Future<List<Result>> futureCharacterList;
  late List<Result> futureCharacterFilter = [];
  bool isLoading = false;

  Future<List<Result>> fetchCharacters(int page) async {
    final response = await http.get(
        Uri.parse("https://rickandmortyapi.com/api/character/?page=$page"));

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

  Future<void> fetchData(
      ValueNotifier loading, bool isLastPage, int page) async {
    loading.value = true;
    try {
      final response = await http.get(
          Uri.parse("https://rickandmortyapi.com/api/character/?page=$page"));

      final request = json.decode(response.body);
      final requestResults = request["results"] as List;
      final requestInstance =
          requestResults.map((data) => Result.fromJson(data)).toList();

      if (request.isEmpty) {
        isLastPage = true;
      }

      for (var iten in requestInstance) {
        futureCharacterListScrollView.add(iten);
      }

      loading.value = false;
    } catch (e) {
      e;
    }
  }
}
