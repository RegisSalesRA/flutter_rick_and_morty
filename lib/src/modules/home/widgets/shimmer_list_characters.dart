import 'package:flutter/material.dart';

import '../../../components/components.dart';
import 'widgets.dart';

class ShimmerCharacters extends StatelessWidget {
  const ShimmerCharacters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Header(changeColor: true),
            const SearchBar(
                onSubmitted: null,
                onTapFilter: null,
                onTap: null,
                changeColor: false,
                onFilter: null,
                controller: null),
            const SizedBox(
              height: 20,
            ),
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
      ),
    );
  }
}
