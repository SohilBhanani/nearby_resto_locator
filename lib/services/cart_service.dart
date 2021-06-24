import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sohil_jd/model/cart_model.dart';
import 'package:sohil_jd/shared/colors.dart';

class CartService with ChangeNotifier {
  List<CartModel> _cart = [];

  List<CartModel> get cart => _cart;

  void addToCart({
    String itemId,
    var item,
    DateTime selectedTime,
    String selectedDay,
    int qty,
    String restoId,
    String restoName
  }) {
    try {
      //item already present
      var existingItem =
          _cart.firstWhere((cartItem) => cartItem.itemId == itemId);
      print('Item Already in cart');

      Fluttertoast.showToast(
          msg: 'Already added to Cart', backgroundColor: kPrim);
    } catch (e) {
      //add to cart
      print('Add to cart executed');
      cart.add(CartModel(
        itemId: itemId,
        item: item,
        selectedTime: selectedTime,
        selectedDay: selectedDay ?? '',
        qty: qty,
        restoId: restoId,
        restoName: restoName
      ));
      notifyListeners();
      Fluttertoast.showToast(
          msg: 'Added to cart', backgroundColor: kPrim);
    }
  }

  clearItem(int index) {
    _cart.removeAt(index);
    notifyListeners();
  }

  clearCart() {
    _cart.clear();
    notifyListeners();
  }

  addQty(index) {
    _cart[index].qty++;
    notifyListeners();
  }

  totalPrice() {
    double sum = 0;
    for (int i = 0; i < _cart.length; i++) {
      double price = _cart[i].item['price'];
      sum += price * _cart[i].qty;
    }
    return sum;
  }

  removeQty(index) {
    _cart[index].qty--;
    if (_cart[index].qty == 0) {
      clearItem(index);
    }
    notifyListeners();
  }
}
