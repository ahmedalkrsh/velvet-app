import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velvet/core/common/widgets/custom_btn.dart';
import 'package:velvet/features/cart/presentation/components/cart_compponent.dart';

class ProductDetailsPage extends StatefulWidget {
  final String image;
  final String name;
  final double price;

  const ProductDetailsPage({
    super.key,
    required this.image,
    required this.name,
    required this.price,
  });

  static const String routeName = '/productDetails';

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;

  void _increment() {
    setState(() {
      quantity++;
    });
  }

  void _decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 51),
                child: SizedBox(
                  width: 356.w,
                  height: 356.h,
                  child: Image.asset(widget.image, fit: BoxFit.fill),
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 14.r,
                        backgroundColor: const Color(0xFFFF6F31),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFC4C4C4)),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              iconSize: 20.sp,
                              onPressed: quantity > 1 ? _decrement : null,
                            ),
                            Text(
                              '$quantity',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              iconSize: 20.sp,
                              onPressed: _increment,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 43.h),
                  CustomButton(
                    text: 'Add to cart',
                    onPressed: () {
                      Navigator.pushNamed(context, CartCompponent.routeName);
                    },
                    width: 312.w,
                    height: 56.h,
                    backgroundColor: const Color(0xFFFFCC48),
                    textStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
