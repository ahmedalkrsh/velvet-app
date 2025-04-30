import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final Icon? icon; 

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.height,
    this.width,
    this.textStyle,
    this.borderRadius,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: height ?? 60.h,
          width: width ?? 358.w,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius ?? BorderRadius.circular(10),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
                Text(text, style: textStyle),
                 SizedBox(
                   width: 8.w
                 ),
                  if (icon != null) ...[icon!, SizedBox(width: 8.w)],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
