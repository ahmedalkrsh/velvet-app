import 'package:flutter/material.dart';

class SplashAnimationManager {
  final TickerProvider vsync;
  late final AnimationController imageController;
  late final AnimationController textController;
  late final AnimationController backgroundController;

  late final Animation<double> scaleAnimation;
  late final Animation<double> rotateAnimation;
  late final Animation<double> textOpacityAnimation;
  late final Animation<Offset> textSlideAnimation;
  late final Animation<Color?> backgroundColorAnimation;

  SplashAnimationManager({required this.vsync});

  void init() {
    imageController = AnimationController(duration: const Duration(milliseconds: 1800), vsync: vsync);
    textController = AnimationController(duration: const Duration(milliseconds: 1200), vsync: vsync);
    backgroundController = AnimationController(duration: const Duration(milliseconds: 3000), vsync: vsync);

    scaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.2, end: 1.05), weight: 75),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 25),
    ]).animate(CurvedAnimation(parent: imageController, curve: Curves.easeOut));

    rotateAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: -0.03, end: 0.03), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.03, end: 0.0), weight: 50),
    ]).animate(CurvedAnimation(parent: imageController, curve: Curves.easeInOut));

    textOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: textController, curve: const Interval(0.1, 0.8, curve: Curves.easeIn)),
    );

    textSlideAnimation = Tween<Offset>(begin: const Offset(0.0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: textController, curve: Curves.easeOutQuad),
    );

    backgroundColorAnimation = ColorTween(
      begin: Colors.white.withOpacity(0.9),
      end: const Color(0xFFF5F5F5),
    ).animate(backgroundController);
  }

  void startAnimations() {
    backgroundController.forward();
    imageController.forward();
    Future.delayed(const Duration(milliseconds: 600), () {
      textController.forward();
    });
  }

  void dispose() {
    imageController.dispose();
    textController.dispose();
    backgroundController.dispose();
  }
}
