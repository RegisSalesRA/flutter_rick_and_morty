import 'package:flutter/material.dart';
import '../../../../config/config.dart';
import '../../../../model/model.dart';
import '../../../components/components.dart';
import '../repository/location_repository.dart';
import '../widgets/widgets.dart'; 
class EarthLocationScreen extends StatefulWidget {
  const EarthLocationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EarthLocationScreen> createState() => _EarthLocationScreenState();
}

class _EarthLocationScreenState extends State<EarthLocationScreen> {
  late RepositoryLocationImp repositoryLocationImp = RepositoryLocationImp();
  late List<Result> residentsByLocation =
      repositoryLocationImp.residentsByLocation;

  @override
  void initState() {
    super.initState();
    repositoryLocationImp
        .fetchEarchLocationResidents(residentsByLocation)
        .then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: Scaffold(
        body: FutureBuilder<LocationPlace>(
            future: repositoryLocationImp.fetchEarchLocation(),
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
