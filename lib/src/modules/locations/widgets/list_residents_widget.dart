import 'package:flutter/material.dart';

import '../../../../model/model.dart';
import '../../../components/components.dart';

class ListResidentsWidget extends StatelessWidget {
  final bool changeColor;
  final List<Result> lista;
  const ListResidentsWidget({
    Key? key,
    required this.changeColor,
    required this.lista,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: 65,
          width: size.width,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.only(left: 5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                width: 75,
                height: 65,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailWidget(
                            image: lista[index].image,
                            tag: lista[index].id.toString(),
                            name: lista[index].name,
                            location: lista[index].location.name,
                            origin: lista[index].origin.name,
                            gender: lista[index].gender!,
                            species: lista[index].species!,
                            status: lista[index].status!,
                            changeColor: changeColor,
                            episode: lista[index].episode)));
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: Image.network(lista[index].image),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
