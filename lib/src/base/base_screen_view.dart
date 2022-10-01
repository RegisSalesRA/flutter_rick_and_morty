import 'package:flutter/material.dart';
import 'package:rick_and_morty/config/colors.dart';

import '../modules/modules.dart';


class BaseScreenView extends StatefulWidget {
  const BaseScreenView({Key? key}) : super(key: key);

  @override
  State<BaseScreenView> createState() => _BaseScreenViewState();
}

class _BaseScreenViewState extends State<BaseScreenView> {
  int currentIndex = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Home(),
          Center(
            child: Text(
              'Page 2',
            ),
          ),
          SplashScreenQuiz()
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: CustomColors.containerColor,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              pageController.jumpToPage(index);
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade700,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: currentIndex == 1
                  ? const ImageIcon(
                      AssetImage("assets/images/characters.png"),
                    )
                  : const ImageIcon(
                      AssetImage("assets/images/characters.png"),
                    ),
              label: 'Characters',
            ),
            BottomNavigationBarItem(
              icon: currentIndex == 1
                  ? const ImageIcon(
                      AssetImage("assets/images/portal.png"),
                    )
                  : const ImageIcon(
                      AssetImage("assets/images/portal.png"),
                    ),
              label: 'Location',
            ),
            BottomNavigationBarItem(
              icon: currentIndex == 2
                  ? const ImageIcon(
                      AssetImage("assets/images/quiz.png"),
                    )
                  : const ImageIcon(
                      AssetImage("assets/images/quiz.png"),
                    ),
              label: 'Quiz',
            ),
          ],
        ),
      ),
    );
  }
}
