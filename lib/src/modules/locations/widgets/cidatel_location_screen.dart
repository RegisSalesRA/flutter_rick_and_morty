import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/src/modules/locations/widgets/list_residents_widget.dart';
import '../../../../config/config.dart';
import '../../../../model/model.dart';
import '../../../components/components.dart';
import 'widgets.dart';

class CidatelLocationScreen extends StatefulWidget {
  const CidatelLocationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CidatelLocationScreen> createState() => _CidatelLocationScreenState();
}

class _CidatelLocationScreenState extends State<CidatelLocationScreen> {
  List<Result> residentsByLocation = [];
  late Future<LocationPlace> futureLocation;

  Future<LocationPlace> fetchEarchLocation() async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/location/3'));

    if (response.statusCode == 200) {
      var locationFetch = LocationPlace.fromJson(jsonDecode(response.body));

      return locationFetch;
    } else {
      throw Exception('Failed to load location');
    }
  }

  Future<void> fetchEarchLocationResidents() async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/location/3'));
    var locationFetch = LocationPlace.fromJson(jsonDecode(response.body));

    for (var item in locationFetch.residents) {
      final response = await http.get(Uri.parse(item));
      var value = Result.fromJson(jsonDecode(response.body));

      if (!mounted) return;
      setState(() {
        residentsByLocation.add(value);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchEarchLocationResidents();
    futureLocation = fetchEarchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: FutureBuilder<LocationPlace>(
            future: futureLocation,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.waiting:
                  return const CustomShimmerLocation();
                case ConnectionState.done:
                  if (snapshot.hasData && !snapshot.hasError) {
                    LocationPlace? data = snapshot.data;
                    return SafeArea(
                        child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 300,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(50)),
                                      child: Image.asset(
                                        'assets/images/cidatel.png',
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    data!.name,
                                    style: const TextStyle(
                                        color: AppThemeLight.primaryColor,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Container(
                                    height: 125,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                            color: Colors.grey.shade300,
                                            width: 2,
                                            style: BorderStyle.solid)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DetailsLocation(
                                          title: "Type",
                                          description: data.type,
                                        ),
                                        DetailsLocation(
                                          title: "Dimension",
                                          description: data.dimension,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    "Residents: ",
                                    style: TextStyle(
                                        color: AppThemeLight.titleDetail,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListResidentsWidget(
                                  lista: residentsByLocation,
                                ),
                              ]),
                        ),
                        Positioned(
                            top: 20,
                            left: 20,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: AppThemeLight.primaryColor,
                                size: 30.0,
                              ),
                            ))
                      ],
                    ));
                  } else {
                    return const ErrorConnection();
                  }
              }
              return Container();
            }),
      ),
    );
  }
}
