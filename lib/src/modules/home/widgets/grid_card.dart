import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/modules/home/widgets/widgets.dart';

class GridCard extends StatelessWidget {
  final List<dynamic> listItens;

  const GridCard({
    Key? key,
    required this.listItens,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        physics: const BouncingScrollPhysics(),
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
              gotoDetailsPage(
                context,
                listItens[index].image,
                listItens[index].id.toString(),
                listItens[index].name,
                listItens[index].location.name,
                listItens[index].origin.name,
                listItens[index].gender,
                listItens[index].species,
                listItens[index].status,
              )
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: listItens[index].toString(),
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
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
