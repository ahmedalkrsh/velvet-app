part of 'favourites_cubit_cubit.dart';

@immutable
 class FavouritesCubitState {
  final List<CartItem> items;

  FavouritesCubitState({this.items = const []});

  FavouritesCubitState copyWith({List<CartItem>? items}) {
    return FavouritesCubitState(items: items ?? this.items);
  }
 }



   
