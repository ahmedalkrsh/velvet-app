import 'package:flutter/material.dart';
import 'package:velvet/core/utils/app_assets.dart';

class SplashAnimatedImage extends StatelessWidget {
  final double imageWidth;
  final Animation<double> rotateAnimation;
  final Animation<double> scaleAnimation;

  const SplashAnimatedImage({
    super.key,
    required this.imageWidth,
    required this.rotateAnimation,
    required this.scaleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([rotateAnimation, scaleAnimation]),
      builder: (context, child) {
        return Transform.rotate(
          angle: rotateAnimation.value,
          child: Transform.scale(
            scale: scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(imageWidth / 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 30,
                    spreadRadius: 2,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Hero(
                tag: 'splash_logo',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(imageWidth / 2),
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
      child: Image.asset(
        AppAssets.introImage,
        width: imageWidth,
        height: imageWidth,
        fit: BoxFit.contain,
        cacheWidth: (imageWidth * 1.5).toInt(), 
        filterQuality: FilterQuality.high,
      ),
    );
  }
}