import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedFadedText extends StatefulWidget {
  final Widget? child;
  final double? direction;

  const AnimatedFadedText({Key? key, this.child, this.direction}) : super(key: key);

  @override
  State<AnimatedFadedText> createState() => _AnimatedFadedTextState();
}

class _AnimatedFadedTextState extends State<AnimatedFadedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    Timer(const Duration(milliseconds: 200), () => _animationController.forward());
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(widget.direction!, 0),
        end: Offset.zero,
      ).animate(_animationController),
      child: FadeTransition(
        opacity: _animationController,
        child: widget.child,
      ),
    );
  }
}