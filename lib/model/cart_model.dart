class CartModel {
  String itemId;
  var item;
  DateTime selectedTime;
  String selectedDay;
  int qty;
  String restoId;
  String restoName;

  CartModel(
      {this.restoId,this.restoName,this.itemId, this.item, this.selectedTime, this.qty, this.selectedDay});
}
