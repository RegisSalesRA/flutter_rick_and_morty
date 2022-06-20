import 'package:flutter/material.dart';
import 'package:rick_and_morty/css/colors.dart';
import 'package:rick_and_morty/pages/home.dart';

class SplashHome extends StatefulWidget {
  const SplashHome({Key? key}) : super(key: key);

  @override
  State<SplashHome> createState() => _SplashHomeState();
}

class _SplashHomeState extends State<SplashHome> with TickerProviderStateMixin {
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
      pageBuilder: (context, animation, secondaryAnimation) => const Home(),
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
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/enviroments/splash_home.jpg"),
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
                  Navigator.of(context).pushReplacement(_createRoute());
                },
                child: Container(
                  height: 60,
                  width: 250,
                  decoration: BoxDecoration(
                    boxShadow: kElevationToShadow[500],
                    borderRadius: BorderRadius.circular(35.0),
                    color: CustomColors.containerColor,
                  ),
                  child: const Center(
                      child: Text(
                    "Press to enter!",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    ));
  }
}
