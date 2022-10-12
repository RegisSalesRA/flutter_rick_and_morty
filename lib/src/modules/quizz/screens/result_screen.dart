import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  const ResultScreen(this.score, {Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/starsbg.jpg'),
            fit: BoxFit.fill,
          )),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.score == 10)
                  Image.asset(
                    'assets/images/maximo.png',
                  ),
                if (widget.score >= 7 && widget.score <= 9)
                  Image.asset(
                    'assets/images/media.png',
                  ),
                if (widget.score <= 6 && widget.score >= 1)
                  Image.asset(
                    'assets/images/abaixo.png',
                  ),
                if (widget.score == 0)
                  Image.asset(
                    'assets/images/zerada.png',
                  ),
                const Text(
                  "You Score is",
                  style: TextStyle(color: Colors.white, fontSize: 34.0),
                ),
                Text(
                  "${widget.score}",
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 85.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Reapeat the quizz",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
