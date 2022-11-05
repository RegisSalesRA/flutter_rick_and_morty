import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../components/components.dart';

class GridCard extends StatelessWidget {
  final List<dynamic> listItens;
  final bool changeColor;
  final ScrollController? controllerScroll;
  const GridCard(
      {Key? key,
      required this.listItens,
      required this.changeColor,
      required this.controllerScroll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        controller: controllerScroll,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 8 / 11.5,
        ),
        itemCount: listItens.length,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () => {
              FocusScope.of(context).unfocus(),
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailWidget(
                        changeColor: changeColor,
                        image: listItens[index].image,
                        tag: listItens[index].id.toString(),
                        name: listItens[index].name,
                        location: listItens[index].location.name,
                        origin: listItens[index].origin.name,
                        gender: listItens[index].gender,
                        species: listItens[index].species,
                        status: listItens[index].status,
                        episode: listItens[index].episode,
                      )))
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: listItens[index].id.toString(),
                      child: Image.network(
                        listItens[index].image,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    listItens[index].name,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: changeColor
                            ? AppThemeDark.primaryColor
                            : AppThemeLight.primaryColor,
                        fontSize: AppTextStyle.title,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
