import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:velvet/core/data/cached/cache_helper.dart' show CacheHelper;
import 'package:velvet/core/helperFunctions/on_generate_route.dart';
import 'package:velvet/core/services/payment_service.dart';
import 'package:velvet/features/cart/logic/cubit/cart_cubit.dart';
import 'package:velvet/features/intro/presentation/views/intro_views.dart' show SplashScreen;
import 'package:velvet/features/myFavourites/presentation/logic/cubit/favourites_cubit_cubit.dart';
import 'package:velvet/features/search/data/location_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await  Hive.initFlutter();
  Hive.registerAdapter(LocationModelAdapter());
  await Hive.openBox<LocationModel>('locationBox');
  await Future.wait<void>( [ StripePaymentService.initStripe(),
   ]  ,  
  ).then((_) => CacheHelper.init(),
  );
  
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => CartCubit()),
      BlocProvider(create: (context) => FavouritesCubit(FavouritesCubitState())),
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) => MaterialApp(
        onGenerateRoute: OnGenerateRoute.generateRoute,
        initialRoute: SplashScreen.routeName,
        theme: ThemeData(
          fontFamily: "Raleway",
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}