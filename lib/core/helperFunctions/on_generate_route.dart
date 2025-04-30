import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velvet/features/cart/presentation/components/cart_compponent.dart';
import 'package:velvet/features/intro/presentation/views/intro_views.dart';
import 'package:velvet/features/locationPicker/presentation/components/location_picker_component.dart';
import 'package:velvet/features/myFavourites/presentation/logic/cubit/favourites_cubit_cubit.dart';
import 'package:velvet/features/payment/presentation/view/payment_view.dart';
import 'package:velvet/features/search/presentation/components/location_and_product_screen.dart.dart';
import 'package:velvet/features/search/presentation/components/product_details_component.dart';
import 'package:velvet/features/splach/presentation/components/splach_component.dart';

import '../../features/myFavourites/presentation/views/my_favourites.dart';

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
              (_) => BlocProvider(
                create: (context) => FavouritesCubit(FavouritesCubitState()),
                child: ProductDetailsPage(
                  image: args['image'],
                  name: args['name'],
                  price: args['price'],
                ),
              ),
        );
      case LocationPickerScreen.routeName:
        
        return MaterialPageRoute(
          builder:
              (_) => LocationPickerScreen(),
        );
      case SplachComponent.routeName:
        return MaterialPageRoute(builder: (_) => const SplachComponent());
      case CartCompponent.routeName:
        return MaterialPageRoute(builder: (_) => const CartCompponent());
      case PaymentPage.routeName:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => PaymentPage(amount: args['amount']),
        );
      case MyFavouritesView.routeName:
        return MaterialPageRoute(builder: (_) => const MyFavouritesView());
      
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const LocationAndProductScreen(),
        );
    }
  }
}
