import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../config/config.dart';
import '../../../../model/model.dart';
import '../../../components/components.dart';
import '../repository/location_repository.dart';
import '../widgets/widgets.dart';

class CidatelLocationScreen extends StatefulWidget {
  final bool changeColor;
  const CidatelLocationScreen({Key? key, required this.changeColor})
      : super(key: key);

  @override
  State<CidatelLocationScreen> createState() => _CidatelLocationScreenState();
}

class _CidatelLocationScreenState extends State<CidatelLocationScreen> {
  late RepositoryLocationImp repositoryLocationImp = RepositoryLocationImp();
  List<Result> residentsByLocation = [];
  late Future<LocationPlace> futureLocation;

  fetchEarchLocationResidents() async {
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
    futureLocation = repositoryLocationImp.fetchEarchLocation(3);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: Scaffold(
        backgroundColor: widget.changeColor ? Colors.black : Colors.white,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    height: size.height * 0.40,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(50)),
                                      child: Image.asset(
                                        'assets/images/cidatel.png',
                                        fit: BoxFit.cover,
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
                                    style: TextStyle(
                                        color: widget.changeColor
                                            ? AppThemeDark.primaryColor
                                            : AppThemeLight.primaryColor,
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
                                  height: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    "Residents: ",
                                    style: TextStyle(
                                        color: widget.changeColor
                                            ? AppThemeDark.primaryColor
                                            : AppThemeLight.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListResidentsWidget(
                                  changeColor: widget.changeColor,
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
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: widget.changeColor
                                    ? AppThemeDark.primaryColor
                                    : AppThemeLight.primaryColor,
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
