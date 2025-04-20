import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:velvet/features/cart/data/models/cart_item_model.dart';

part 'cart_state.dart';


class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());

  void addToCart(CartItem item) {
    final updatedList = List<CartItem>.from(state.items)..add(item);
    emit(state.copyWith(items: updatedList));
  }

  void removeFromCart(CartItem item) {
    final updatedList = List<CartItem>.from(state.items)..remove(item);
    emit(state.copyWith(items: updatedList));
  }

  void clearCart() {
    emit(state.copyWith(items: []));
  }
}
