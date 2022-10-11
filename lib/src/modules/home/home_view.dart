import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/modules/home/repository/home_repository.dart';

import '../../../config/config.dart';
import '../../../model/model.dart';
import '../../components/components.dart';
import 'widgets/widgets.dart';

class Home extends StatefulWidget {
  final VoidCallback themeColor;
  final bool changeColor;
  const Home({Key? key, required this.themeColor, required this.changeColor})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RepositoryHomeImp repositoryHomeImp = RepositoryHomeImp();
  late Future<List<Result>> fetchCharacters =
      repositoryHomeImp.fetchCharacters();
  late Future<List<Result>> futureCharacterList =
      repositoryHomeImp.futureCharacterList;
  late List<Result> futureCharacterFilter =
      repositoryHomeImp.futureCharacterFilter;
  late String searchString = repositoryHomeImp.searchString;
  late bool isLoading = repositoryHomeImp.isLoading;

  final searchController = TextEditingController();

  void limparControlers() {
    searchController.clear();
  }

  void refreshPage() {
    setState(() {
      futureCharacterFilter.clear();
    });
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
    futureCharacterList = fetchCharacters;
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
              return const ShimmerCharacters();
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
                              changeColor: widget.changeColor,
                              controller: searchController,
                              onFilter: (value) {
                                setState(() {
                                  searchString = value.toLowerCase().toString();
                                });
                              },
                              onSubmitted: (valorInputSearch) async {
                                loadingPage();
                                await repositoryHomeImp.fetchFilterCharacters(
                                    valorInputSearch, futureCharacterFilter);
                                limparControlers();
                                setState(() {
                                  searchString = '';
                                });
                                FocusScope.of(context).unfocus();
                              },
                              onTapFilter: () async {
                                loadingPage();

                                await repositoryHomeImp.fetchFilterCharacters(
                                    searchString, futureCharacterFilter);
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
                                  changeColor: widget.changeColor,
                                  data: data,
                                  searchString: searchString),
                            if (searchString.isEmpty || searchString == '')
                              GridCard(
                                changeColor: widget.changeColor,
                                listItens: data!,
                              ),
                          ] else if (futureCharacterFilter.isNotEmpty) ...[
                            if (searchString.isNotEmpty)
                              ListViewCard(
                                  changeColor: widget.changeColor,
                                  data: futureCharacterFilter,
                                  searchString: searchString),
                            if (searchString.isEmpty || searchString == '')
                              GridCard(
                                changeColor: widget.changeColor,
                                listItens: futureCharacterFilter,
                              ),
                          ],
                        ]),
                      ),
                      Positioned(
                        top: 15,
                        right: 15,
                        child: GestureDetector(
                          onTap: () {
                            return widget.themeColor();
                          },
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: widget.changeColor == true
                                ? const Icon(
                                    CupertinoIcons.brightness,
                                    color: Colors.orangeAccent,
                                    key: ValueKey('iconA'),
                                  )
                                : const Icon(
                                    CupertinoIcons.moon_stars,
                                    color: AppThemeDark.primaryColor,
                                    key: ValueKey('iconB'),
                                  ),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                          ),
                        ),
                      ),
                      isLoading
                          ? Container(
                              color: Colors.black.withOpacity(0.5),
                              width: size.width,
                              height: size.height,
                              child: const Center(
                                  child: CupertinoActivityIndicator(
                                radius: 25,
                                color: AppThemeLight.primaryColor,
                              )))
                          : Container()
                    ],
                  ),
                );
              } else {
                return const ErrorConnection();
              }
          }
          return Container();
        });
  }
}
