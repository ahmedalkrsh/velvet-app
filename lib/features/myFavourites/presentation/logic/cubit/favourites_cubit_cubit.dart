import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:velvet/features/cart/data/models/cart_item_model.dart';

part 'favourites_cubit_state.dart';

class FavouritesCubit extends Cubit<FavouritesCubitState> {
  FavouritesCubit(super.initialState) ;

  void addToFavourites(CartItem item) {
    final updatedList = List<CartItem>.from(state.items)..add(item);
    emit(state.copyWith(items: updatedList));
  }

   void removeFromFavourites(CartItem item) {
    final updatedList = List<CartItem>.from(state.items)..remove(item);
    emit(state.copyWith(items: updatedList));
   }
}
