import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velvet/core/common/widgets/custom_btn.dart';
import 'package:velvet/features/cart/data/models/cart_item_model.dart';
import 'package:velvet/features/cart/logic/cubit/cart_cubit.dart';
import 'package:velvet/features/cart/presentation/components/cart_compponent.dart';
import 'package:velvet/features/myFavourites/presentation/logic/cubit/favourites_cubit_cubit.dart';

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
  bool isFavourite = false;

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
              padding: EdgeInsets.all(16.w),
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
  child: IconButton(
    icon: Icon(
      Icons.favorite,
      color: isFavourite ? Colors.red : Colors.white,
      size: 16.sp,
    ),
    onPressed: () {
      final item = CartItem(
        image: widget.image,
        name: widget.name,
        price: widget.price,
        quantity: quantity,
      );

      final favouritesCubit = context.read<FavouritesCubit>();
      if (isFavourite) {
        favouritesCubit.removeFromFavourites(item);
      } else {
        favouritesCubit.addToFavourites(item);
      }

      setState(() {
        isFavourite = !isFavourite;
      });
    },
  ),
)

                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
  '\$${(widget.price * quantity).toStringAsFixed(2)}',
  style: TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  ),
),

                      Container(
                       height: 31.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFC4C4C4)),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.remove,
                                color:
                                    quantity > 1 ? Colors.black : Colors.grey,
                              ),
                              iconSize: 20.sp,
                              onPressed: quantity > 1 ? _decrement : null,
                            ),
                            Text(
                              '$quantity',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              iconSize: 20 .sp,
                              onPressed: _increment, 
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  CustomButton(
                    text: 'Add to cart',
                    onPressed: () {
                      context.read<CartCubit>().addToCart(
  CartItem(
    image: widget.image,
    name: widget.name,
    price: widget.price,
    quantity: quantity, 
  ),
);
Navigator.pushNamed(context, CartCompponent.routeName);

                     
                    },
                    width: 312.w,
                    height: 50.h,
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
