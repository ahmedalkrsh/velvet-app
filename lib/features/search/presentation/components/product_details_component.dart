import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Column(
        children: [
          Container(
              alignment: Alignment.center,
              width: 356.w,
              height: 356.h,
            child: Image.asset(image,fit:BoxFit.fill ,)),
          SizedBox(height: 20),
          Text(name, style: TextStyle(fontSize: 24)),
          Text('\$${price.toStringAsFixed(2)}', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
