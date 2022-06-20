import 'package:flutter/material.dart';
import 'package:rick_and_morty/css/colors.dart';

class ChracterWidget extends StatelessWidget {
  final int? id;
  final String? name;
  final String? image;
  final String? tagHero;
  const ChracterWidget({Key? key, this.name, this.image, this.id, this.tagHero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Hero(
              tag: tagHero!,
              child: Image.network(
                image!,
                fit: BoxFit.cover,
              ))),
      footer: Container(
          decoration: const BoxDecoration(
            color: CustomColors.containerColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          height: 25,
          child: GridTileBar(
            title: Center(child: Text(name!)),
          )),
    );
  }
}
