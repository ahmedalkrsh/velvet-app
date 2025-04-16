import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velvet/core/common/widgets/custom_btn.dart';
import 'package:velvet/core/utils/app_assets.dart';
import 'package:velvet/features/search/presentation/components/location_and_product_screen.dart.dart';

class SplachComponent extends StatelessWidget {
  const SplachComponent({super.key});
  static const routeName = '/splachComponent';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            const Image(
              image: AssetImage(AppAssets.splachImage),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),

            Positioned(
              top: 200.h,
              left: 0,
              right: 0,
              bottom: 0.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 20.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "VELVET\nROOM",
                      style: TextStyle(
                        fontSize: 44.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Quando",
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Text.rich(
                      TextSpan(
                        text:
                            'Transform your bedroom into a luxurious velvet feel.\n'
                            'A new experience in bedroom designs.\n'
                            'Add to your room a... ',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Quattrocento',
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'Read more',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Quattrocento',
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.h),

                    Center(
                      child: Text(
                        ' Discover new and\nunique designs now',
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Quando',
                          color: Color(0xFF626262),
                        ),
                      ),
                    ),

                    const SizedBox(height: 88),

                    CustomButton(
                      width: double.infinity,
                      height: 55.h,
                      text: 'Start shopping',
                      textStyle: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Quando',
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          LocationAndProductScreen.routeName,
                        );
                      },
                      backgroundColor: const Color(0xFFFFCC48),
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
