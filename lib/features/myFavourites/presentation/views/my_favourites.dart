import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velvet/features/cart/presentation/widgets/custom_cart_app_bar.dart';
import 'package:velvet/features/myFavourites/presentation/logic/cubit/favourites_cubit_cubit.dart';

class MyFavouritesView extends StatelessWidget {
  const MyFavouritesView({super.key});
  static const String routeName = "MyFavouritesView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(text: 'My Favourites'),
      ),
      body: BlocBuilder<FavouritesCubit, FavouritesCubitState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(
              child: Text("لا يوجد منتجات في المفضلة"),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Image.asset(
                    item.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item.name),
                  subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context
                          .read<FavouritesCubit>()
                          .removeFromFavourites(item);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
