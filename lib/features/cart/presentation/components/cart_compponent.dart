import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velvet/core/common/widgets/custom_btn.dart';
import 'package:velvet/features/cart/logic/cubit/cart_cubit.dart';
import 'package:velvet/features/cart/presentation/widgets/custom_cart_app_bar.dart';
import 'package:velvet/features/payment/presentation/view/payment_view.dart';

class CartCompponent extends StatefulWidget {
  const CartCompponent({super.key});
  static const String routeName = '/cart';

  @override
  State<CartCompponent> createState() => _CartCompponentState();
}

class _CartCompponentState extends State<CartCompponent> {
  

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
final total = cubit.totalPrice;
final discount = cubit.discount;
final finalTotal = cubit.finalTotal;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(text: 'Cart',)),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
           if (state.items.isEmpty) {
             return Center(child: Text("Your cart is empty."));
           }
          return Padding(
            padding: EdgeInsets.all(16.w),
            child:
                    Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.items.length,
                            itemBuilder: (context, index) {
                              final item = state.items[index];
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
                                          Row(
                                            children: [
                                              Text(
                                                item.name,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Spacer(),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ), onPressed: () {context.read<CartCubit>().removeFromCart(item);  },)
                                            ],
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
                        SizedBox(height: 16.h),
                        Container(
                          
                          padding: EdgeInsets.all(8 .w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),),

                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Total before discount :',
                                    style: TextStyle(
                                     color: Color(0xff757575)  
                                    )),
                                  Spacer(),
                                    Text('\$${total.toStringAsFixed(2)}'),
                                ],
                              ),
                              SizedBox(height: 16.h),
                               Row(
                                children: [
                                  Text(
                                    'Discount:',
                                    style: TextStyle(
                                     color: Color(0xff757575)  
                                    )),
                                  Spacer(),
                                  Text('-\$${discount.toStringAsFixed(2)}'),
                               ]),
                              SizedBox(height: 16.h),
                               Row(
                                children: [
                                  Text(
                                    'Final total:',
                                    style: TextStyle(
                                     color: Color(0xff757575)  
                                    )),
                                  Spacer(),
                                   Text('\$${finalTotal.toStringAsFixed(2)}'),
                                ]
                               ),
                              CustomButton(text: 'Proceed to checkout', onPressed: () {
                                Navigator.pushNamed(
  context,
  PaymentPage.routeName,
  arguments: {
    'amount': finalTotal,
  },
);

                                },backgroundColor: Color(0xffFFCC48),
                              icon: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                                textStyle: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
          );
        },
      ),
    );
  }
}

