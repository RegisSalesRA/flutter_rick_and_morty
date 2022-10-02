import 'package:flutter/material.dart';

import 'widgets.dart';

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
              FocusScope.of(context).unfocus(),
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailWidget(
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
