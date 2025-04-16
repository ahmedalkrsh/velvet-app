import 'package:flutter/material.dart';
import 'package:velvet/features/cart/presentation/components/cart_compponent.dart';
import 'package:velvet/features/locationPicker/presentation/components/location_picker_component.dart';
import 'package:velvet/features/search/presentation/components/location_and_product_screen.dart.dart';
import 'package:velvet/features/search/presentation/components/product_details_component.dart';
import 'package:velvet/features/splach/presentation/components/splach_component.dart';

class OnGenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LocationAndProductScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const LocationAndProductScreen(),
        );

      case ProductDetailsPage.routeName:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) => ProductDetailsPage(
                image: args['image'],
                name: args['name'],
                price: args['price'],
              ),
        );
      case LocationPickerScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LocationPickerScreen());
      case SplachComponent.routeName:
        return MaterialPageRoute(builder: (_) => const SplachComponent());
      case CartCompponent.routeName:
        return MaterialPageRoute(builder: (_) => const CartCompponent());

      default:
        return MaterialPageRoute(
          builder: (_) => const LocationAndProductScreen(),
        );
    }
  }
}
