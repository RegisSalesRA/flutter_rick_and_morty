import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../model/model.dart';

class RepositoryLocationImp {
  List<Result> residentsByLocation = [];
  late Future<LocationPlace> futureLocation;

  Future<LocationPlace> fetchEarchLocation() async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/location/1'));

    if (response.statusCode == 200) {
      var locationFetch = LocationPlace.fromJson(jsonDecode(response.body));

      return locationFetch;
    } else {
      throw Exception('Failed to load location');
    }
  }

  Future<List<Result>> fetchEarchLocationResidents(lista) async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/location/1'));
    var locationFetch = LocationPlace.fromJson(jsonDecode(response.body));

    for (var item in locationFetch.residents) {
      final response = await http.get(Uri.parse(item));
      var value = Result.fromJson(jsonDecode(response.body));

      lista.add(value);
    }
    return lista;
  }
}