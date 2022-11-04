import 'package:flutter/material.dart';
import 'package:rick_and_morty/config/theme_color.dart';

import '../modules/modules.dart';

class BaseScreenView extends StatefulWidget {
  const BaseScreenView({Key? key}) : super(key: key);

  @override
  State<BaseScreenView> createState() => _BaseScreenViewState();
}

class _BaseScreenViewState extends State<BaseScreenView> {
  int currentIndex = 0;
  final pageController = PageController();
  bool changeColor = false;
  themeDarkLight() {
    setState(() {
      changeColor = !changeColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: changeColor
          ? AppThemeDark.backgroundColor
          : AppThemeLight.backgroundColor,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Home(
            changeColor: changeColor,
            themeColor: () => themeDarkLight(),
          ),
          LocationScreen(
            changeColor: changeColor,
          ),
          SplashScreenQuiz(
            changeColor: changeColor,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: changeColor
            ? AppThemeDark.primaryColor
            : AppThemeLight.primaryColor,
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
    );
  }
}
