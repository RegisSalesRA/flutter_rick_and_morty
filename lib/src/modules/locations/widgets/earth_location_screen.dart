import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../config/config.dart';
import '../../../../model/model.dart';
import '../../../components/components.dart';
import '../../home/widgets/widgets.dart';

class EarthLocationScreen extends StatefulWidget {
  const EarthLocationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EarthLocationScreen> createState() => _EarthLocationScreenState();
}

class _EarthLocationScreenState extends State<EarthLocationScreen> {
  var residentsByLocationUrl = [];
  var residentsByLocation = [];
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

  Future<void> fetchEarchLocationResidents() async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/location/1'));
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
    final size = MediaQuery.of(context).size;
    return FutureBuilder<LocationPlace>(
        future: futureLocation,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.waiting:
              return Scaffold(
                body: SafeArea(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Header(),
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
                )),
              );

            case ConnectionState.done:
              if (snapshot.hasData && !snapshot.hasError) {
                LocationPlace? data = snapshot.data;
                return Scaffold(
                    body: SafeArea(
                        child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: size.height * 0.40,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(50)),
                                  child: Image.asset(
                                    'assets/images/earth.png',
                                    fit: BoxFit.fill,
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Type: ",
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: AppThemeLight.titleDetail,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Expanded(
                                          child: Text(
                                            data.type,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: AppThemeLight
                                                    .subTitleDescription,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "Dimension: ",
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: AppThemeLight.titleDetail,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Expanded(
                                          child: Text(
                                            data.dimension,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: AppThemeLight
                                                    .subTitleDescription,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                  height: 65,
                                  width: size.width,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: residentsByLocation.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        padding: const EdgeInsets.only(left: 5),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                        width: 75,
                                        height: 65,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailWidget(
                                                          image:
                                                              residentsByLocation[
                                                                      index]
                                                                  .image,
                                                          tag:
                                                              residentsByLocation[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                          name:
                                                              residentsByLocation[
                                                                      index]
                                                                  .name,
                                                          location:
                                                              residentsByLocation[
                                                                      index]
                                                                  .location
                                                                  .name,
                                                          origin:
                                                              residentsByLocation[
                                                                      index]
                                                                  .origin
                                                                  .name,
                                                          gender:
                                                              residentsByLocation[
                                                                      index]
                                                                  .gender,
                                                          species:
                                                              residentsByLocation[
                                                                      index]
                                                                  .species,
                                                          status:
                                                              residentsByLocation[
                                                                      index]
                                                                  .status,
                                                          episode:
                                                              residentsByLocation[
                                                                      index]
                                                                  .episode,
                                                        )));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(25)),
                                            child: Hero(
                                              tag: residentsByLocation[index]
                                                  .id
                                                  .toString(),
                                              child: Image.network(
                                                  residentsByLocation[index]
                                                      .image),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
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
                )));
              }

              SafeArea(
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

          return Container();
        });
  }
}
