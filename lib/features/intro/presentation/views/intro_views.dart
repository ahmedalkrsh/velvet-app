import 'package:flutter/material.dart';
import 'package:velvet/core/utils/app_assets.dart';
import 'package:velvet/features/intro/presentation/logic/splach_animated_manger.dart';
import 'package:velvet/features/intro/presentation/widgets/animated_image.dart';
import 'package:velvet/features/intro/presentation/widgets/animated_text.dart';
import 'package:velvet/features/splach/presentation/components/splach_component.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final SplashAnimationManager _animationManager;
  bool _isNavigating = false;

  @override
  void initState() { 
    super.initState();
    _animationManager = SplashAnimationManager(vsync: this)..init();
    _animationManager.startAnimations();
    _navigateAfterDelay();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheImage();
  }

  void _navigateAfterDelay() {
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted && !_isNavigating) {
        _isNavigating = true; 
        Navigator.pushReplacementNamed(context, SplachComponent.routeName);
      }
    });
  }

  void _precacheImage() {
    precacheImage(const AssetImage(AppAssets.introImage), context);
  }

  @override
  void dispose() {
    _animationManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width * 0.6;
    return AnimatedBuilder(
      animation: _animationManager.backgroundColorAnimation,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _animationManager.backgroundColorAnimation.value,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SplashAnimatedImage(
                  imageWidth: imageWidth,
                  rotateAnimation: _animationManager.rotateAnimation,
                  scaleAnimation: _animationManager.scaleAnimation,
                ),
                const SizedBox(height: 40),
                SplashAnimatedText(
                  opacityAnimation: _animationManager.textOpacityAnimation,
                  slideAnimation: _animationManager.textSlideAnimation,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
