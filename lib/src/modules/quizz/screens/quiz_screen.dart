import 'package:flutter/material.dart';
import 'result_screen.dart';
import '../mock/mock.dart';

class QuizzScreen extends StatefulWidget {
  const QuizzScreen({Key? key}) : super(key: key);

  @override
  _QuizzScreenState createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  int score = 0;
  bool btnPressed = false;
  PageController? _controller;
  String btnText = "Next Question";
  bool answered = false;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/starsbg.jpg'),
          fit: BoxFit.fill,
        )),
        child: PageView.builder(
          itemCount: questions.length,
          controller: _controller!,
          onPageChanged: (page) {
            if (page == questions.length - 1) {
              setState(() {
                btnText = "See Results";
              });
            }
            setState(() {
              answered = false;
            });
          },
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Text(
                    "Question ${index + 1}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 100.0,
                    child: Text(
                      "${questions[index].question}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
                for (int i = 0; i < questions[index].answers!.length; i++)
                  Container(
                    width: double.infinity,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                            color: btnPressed
                                ? questions[index].answers!.values.toList()[i]
                                    ? Colors.green
                                    : Colors.red
                                : Colors.grey.shade800,
                            width: 1)),
                    margin: const EdgeInsets.only(
                        bottom: 20.0, left: 12.0, right: 12.0),
                    child: RawMaterialButton(
                      onPressed: !answered
                          ? () {
                              if (questions[index]
                                  .answers!
                                  .values
                                  .toList()[i]) {
                                score++;
                              } else {}
                              setState(() {
                                btnPressed = true;
                                answered = true;
                              });
                            }
                          : null,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Text(questions[index].answers!.keys.toList()[i],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: btnPressed
                                        ? questions[index]
                                                .answers!
                                                .values
                                                .toList()[i]
                                            ? Colors.green
                                            : Colors.red
                                        : Colors.transparent,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Center(
                                  child: btnPressed
                                      ? questions[index]
                                              .answers!
                                              .values
                                              .toList()[i]
                                          ? const Icon(
                                              Icons.check,
                                              size: 20,
                                              color: Colors.white,
                                            )
                                          : const Icon(
                                              Icons.cancel,
                                              size: 20,
                                            )
                                      : Container(),
                                ),
                              ),
                            )
                          ]),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (_controller!.page?.toInt() == questions.length - 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultScreen(score)));
                    } else {
                      _controller!.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInExpo);

                      setState(() {
                        btnPressed = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      textStyle: const TextStyle(fontSize: 16)),
                  child: Text(
                    btnText,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
