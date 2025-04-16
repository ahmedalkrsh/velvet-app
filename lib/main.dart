import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velvet/core/data/cached/cache_helper.dart' show CacheHelper;
import 'package:velvet/core/helperFunctions/on_generate_route.dart';
import 'package:velvet/features/locationPicker/presentation/components/location_picker_component.dart';
import 'package:velvet/features/search/presentation/components/location_and_product_screen.dart.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp(
        onGenerateRoute: OnGenerateRoute.generateRoute,
        initialRoute: LocationAndProductScreen.routeName,
      
        theme: ThemeData(
          fontFamily: "Raleway"
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold( 
          appBar: AppBar(
            title: Text("Velvet"),
          ),
          
        ),
      ),
    );
  }
}