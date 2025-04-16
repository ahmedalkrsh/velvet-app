import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velvet/features/cart/data/models/cart_item_model.dart';

class CartCompponent extends StatefulWidget {
  const CartCompponent({super.key});
  static const String routeName = '/cart';

  @override
  State<CartCompponent> createState() => _CartCompponentState();
}

class _CartCompponentState extends State<CartCompponent> {
  final List<CartItem> cartItems = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final item = ModalRoute.of(context)?.settings.arguments;
    if (item is CartItem) {
      setState(() {
        cartItems.add(item);
      });
    }
  }

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
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child:
            cartItems.isEmpty
                ? Center(child: Text("Your cart is empty."))
                : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            item.image,
                            width: 80.w,
                            height: 80.h,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  '\$${item.price.toStringAsFixed(2)} x ${item.quantity}',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
