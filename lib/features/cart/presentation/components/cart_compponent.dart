import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCompponent extends StatefulWidget {
  const CartCompponent({super.key});
  static const String routeName = '/cart';
  @override
  State<CartCompponent> createState() => _CartCompponentState();
}

class _CartCompponentState extends State<CartCompponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black, size: 25.sp),
        title: Text(
          'Cart',
          style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Container(
              width: 45.w,
              height: 45.h,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.amber,
                  size: 30.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
