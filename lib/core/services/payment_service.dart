import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class StripePaymentService {
  static final String _stripeSecretKey = dotenv.env['STRIPE_SECRET_KEY'] ?? '';

  static final Dio _dio = Dio();
 void initializePayment() {
    // الآن يمكنك استخدام المفتاح في إعدادات Stripe
    print('Stripe Secret Key: $_stripeSecretKey');
  }
  /// إعداد Stripe بمفتاح النشر
  static Future<void> initStripe() async {
    Stripe.publishableKey = 'pk_test_51QcXEhPXuLAXQg1SwL8FjR8hqOmLQ5sUncIQOjCrNWtyqrslVvuhIRzGduUysufjlVRiMP77rPHU4TVeisu1iuMb00WKo2bjPg'; // حط المفتاح بتاعك هنا
    await Stripe.instance.applySettings();
  }

  /// إنشاء PaymentIntent من السيرفر
  static Future<void> makePayment({
    required int amount,
    required String currency,
  }) async {
    try {
      // 1. إنشاء payment intent
      final paymentIntentData = await _createPaymentIntent(amount, currency);

      // 2. تهيئة واجهة الدفع
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          merchantDisplayName: 'Velvet App',
        ),
      );

      // 3. عرض واجهة الدفع
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print('❌ Payment Error: $e');
      rethrow;
    }
  }

  /// إنشاء PaymentIntent باستخدام Dio
  static Future<Map<String, dynamic>> _createPaymentIntent(
      int amount, String currency) async {
    try {
      final response = await _dio.post(
        'https://api.stripe.com/v1/payment_intents',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}', // secret key بتاعك
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: {
          'amount': amount.toString(),
          'currency': currency,
          'payment_method_types[]': 'card',
        },
      );

      return response.data;
    } catch (e) {
      print('❌ Create PaymentIntent Error: $e');
      throw Exception('Failed to create payment intent');
    }
  }
}
