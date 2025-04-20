import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velvet/core/data/cached/cache_helper.dart' show CacheHelper;
import 'package:velvet/core/helperFunctions/on_generate_route.dart';
import 'package:velvet/features/cart/logic/cubit/cart_cubit.dart';
import 'package:velvet/features/splach/presentation/components/splach_component.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  runApp(BlocProvider(create: (context) => CartCubit(), child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp(
        onGenerateRoute: OnGenerateRoute.generateRoute,
        initialRoute: SplachComponent.routeName,

        theme: ThemeData(fontFamily: "Raleway"),
        debugShowCheckedModeBanner: false,
        home: Scaffold(appBar: AppBar(title: Text("Velvet"))),
      ),
    );
  }
}
