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
            image: AssetImage('assets/images/resultbg.jpg'),
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
                    height: 400,
                  ),
                if (widget.score >= 7 && widget.score <= 9)
                  Image.asset(
                    'assets/images/media.png',
                    height: 400,
                  ),
                if (widget.score <= 6 && widget.score >= 1)
                  Image.asset(
                    'assets/images/abaixo.png',
                    height: 400,
                  ),
                if (widget.score == 0)
                  Image.asset(
                    'assets/images/zerada.png',
                    height: 400,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Score result: ",
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
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "back to home",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
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
