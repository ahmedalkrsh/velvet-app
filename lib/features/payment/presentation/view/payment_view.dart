import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velvet/core/common/widgets/custom_btn.dart';
import 'package:velvet/core/services/payment_service.dart';

class PaymentPage extends StatelessWidget {
   static const String routeName = '/payment';
  final double amount;
  

  const PaymentPage({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment", style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Card Information", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 20.h),

            // Placeholder for card (UI only - no actual input fields)
            Container(
              width: double.infinity,
              height: 180.h,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("**** **** **** 4242", style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Exp: 12/34", style: TextStyle(fontSize: 16.sp)),
                      Text("CVC: ***", style: TextStyle(fontSize: 16.sp)),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 30.h),

            // Payment Summary
            Text("Order Summary", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: TextStyle(fontSize: 16.sp)),
                Text("\$${amount.toStringAsFixed(2)}", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),

              ],
            ),
            Spacer(),
            Row(
              children: [
                Text("")
              ],
            ),

            // Pay Button
            CustomButton(
              text: "Pay Now",
              backgroundColor: Color(0xffFFCC48),
              icon: Icon(Icons.lock, color: Colors.white),
              textStyle: TextStyle(color: Colors.white, fontSize: 18.sp),
              onPressed: () async {
                try {
                  await StripePaymentService.makePayment(
                    amount: (amount * 100).toInt(), // Stripe expects amount in cents
                    currency: "usd",
                  );
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ Payment Successful")));
                  Navigator.pop(context); // رجوع بعد الدفع
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("❌ Payment Failed")));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
