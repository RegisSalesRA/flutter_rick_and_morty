import 'package:flutter/material.dart'; 

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 60,
                          ),
                        ),
                      ) ;
  }
}