import 'package:flutter/material.dart';
import 'package:rick_and_morty/config/theme_color.dart';
import 'package:like_button/like_button.dart';
import 'screens/screens.dart';

class SplashScreenQuiz extends StatefulWidget {
  final bool changeColor;
  const SplashScreenQuiz({Key? key, required this.changeColor})
      : super(key: key);

  @override
  State<SplashScreenQuiz> createState() => _SplashScreenQuizState();
}

class _SplashScreenQuizState extends State<SplashScreenQuiz>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 6),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const QuizzScreen(),
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        const begin = Offset(0.0, 15.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppThemeDark.backgroundColor,
          image: DecorationImage(
            image: AssetImage("assets/images/splash_home.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ScaleTransition(
              scale: _animation,
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(_createRoute());
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 250,
                        decoration: BoxDecoration(
                          boxShadow: kElevationToShadow[500],
                          borderRadius: BorderRadius.circular(35.0),
                          color: widget.changeColor
                              ? AppThemeDark.primaryColor
                              : AppThemeLight.primaryColor,
                        ),
                        child: const Center(
                            child: Text(
                          "Start Quiz!",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      )),
    );
  }
}
