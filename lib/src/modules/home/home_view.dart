import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/modules/home/repository/home_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../config/config.dart';
import '../../../entity/entity.dart';
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
  // Enviroments
  // List<Result> characterList = [];
  int page = 1;
  bool isLastPage = false;
  final loading = ValueNotifier(true);
  //Repositories
  RepositoryHomeImp repositoryHomeImp = RepositoryHomeImp();
  late Future<List<Result>> fetchCharacters =
      repositoryHomeImp.fetchCharacters(page);
  late Future<List<Result>> futureCharacterList =
      repositoryHomeImp.futureCharacterList;
  late List<Result> futureCharacterFilter =
      repositoryHomeImp.futureCharacterFilter;
  late List<Result> futureCharacterListScrollView =
      repositoryHomeImp.futureCharacterListScrollView;
  late String searchString = repositoryHomeImp.searchString;
  late bool isLoading = repositoryHomeImp.isLoading;

  //Controllers
  final searchController = TextEditingController();
  late final ScrollController _controller;
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

  void infinitScroll() async {
    if (_controller.offset == _controller.position.maxScrollExtent) {
      if (!isLastPage) {
        page++;
        fetchData();
        print(page);
        print("Esta carregando? $isLoading");
        print(isLastPage);
      }
    }
  }

  Future<void> fetchData() async {
    loading.value = true;
    try {
      final response = await http.get(
          Uri.parse("https://rickandmortyapi.com/api/character/?page=$page"));

      final request = json.decode(response.body);
      final requestResults = request["results"] as List;
      final requestInstance =
          requestResults.map((data) => Result.fromJson(data)).toList();

      if (request.isEmpty) {
        setState(() {
          isLastPage = true;
        });
      }

      for (var iten in requestInstance) {
        setState(() {
          futureCharacterListScrollView.add(iten);
        });
      }
      print(futureCharacterListScrollView.length);
      loading.value = false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(infinitScroll);
    fetchData();
    futureCharacterList = fetchCharacters;
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeListener(infinitScroll);
    searchController;
    super.dispose();
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
              return ShimmerCharacters(
                changeColor: widget.changeColor,
              );
            case ConnectionState.done:
              if (snapshot.hasData && !snapshot.hasError) {
                List<Result>? data = snapshot.data;
                print(data!.length);
                return SafeArea(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Header(
                            changeColor: widget.changeColor,
                          ),
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
                              SizedBox(
                                height: 400,
                                child: GridCard(
                                  changeColor: widget.changeColor,
                                  listItens: futureCharacterListScrollView,
                                  controllerScroll: _controller,
                                ),
                              ),
                          ] else if (futureCharacterFilter.isNotEmpty) ...[
                            if (searchString.isNotEmpty)
                              ListViewCard(
                                  changeColor: widget.changeColor,
                                  data: futureCharacterFilter,
                                  searchString: searchString),
                            if (searchString.isEmpty || searchString == '')
                              GridCard(
                                controllerScroll: _controller,
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
                            duration: const Duration(milliseconds: 1000),
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
                      LoadingWidgetScrollView(isLoading: loading),
                      isLoading
                          ? Container(
                              color: Colors.black.withOpacity(0.5),
                              width: size.width,
                              height: size.height,
                              child: Center(
                                  child: CupertinoActivityIndicator(
                                radius: 25,
                                color: widget.changeColor
                                    ? AppThemeDark.primaryColor
                                    : AppThemeLight.primaryColor,
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
