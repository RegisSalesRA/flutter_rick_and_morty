import 'package:flutter/material.dart';

import '../../../components/components.dart';

class CustomShimmerLocation extends StatelessWidget {
  const CustomShimmerLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomShimmer(
            height: size.height * 0.40,
            width: size.width,
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(50)),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CustomShimmer(
              height: 50,
              width: 200,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CustomShimmer(
              height: 125,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CustomShimmer(
              height: 35,
              width: 125,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 65,
              width: size.width,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.only(left: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    width: 75,
                    height: 65,
                    child: const CustomShimmer(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      height: 89,
                      width: 80,
                    ),
                  );
                },
              ),
            ),
          )
        ]),
      ),
    );
  }
}
