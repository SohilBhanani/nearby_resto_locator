import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sohil_jd/model/cart_model.dart';
import 'package:sohil_jd/services/payment_service.dart';
import 'package:sohil_jd/shared/colors.dart';
import 'package:sohil_jd/shared/ui_helper.dart';

import '../services/cart_service.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  PaymentService paymentService = Provider.of<PaymentService>(context);
    var cartService = Provider.of<CartService>(context, listen: false);
    var cartServ = Provider.of<CartService>(context);
    String totalPrice = cartServ.totalPrice().toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartService>(
              builder: (ctx, value, _) {
                List<CartModel> cart = value.cart;
                return ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (BuildContext context, index) {
                      // return CartTile(cart:cart[index],index:index);
                      return Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              child:
                                  Image.network(cart[index].item['images'][0]),
                            ),
                            horizontalSpaceTiny,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cart[index].item['name'],
                                  style: tx16,
                                ),
                                Text('From: ${cart[index].restoName}'),
                                cart[index].selectedDay == ''
                                    ? Text(
                                        "Pickup today at ${DateFormat.jm().format(cart[index].selectedTime)}",
                                        style: tx14,
                                      )
                                    : Text(
                                        'Scheduled Pickup: on ${cart[index].selectedDay} at ${DateFormat.jm().format(cart[index].selectedTime)}',
                                        style: tx14,
                                      ),
                                verticalSpaceSmall,
                                Row(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              Provider.of<CartService>(context,
                                                      listen: false)
                                                  .addQty(index);
                                            },
                                          ),
                                          horizontalSpaceTiny,
                                          Text(
                                            '${cart[index].qty}',
                                            style: tx16.copyWith(
                                                fontWeight: FontWeight.normal),
                                          ),
                                          horizontalSpaceTiny,
                                          IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              Provider.of<CartService>(context,
                                                      listen: false)
                                                  .removeQty(index);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                "\$ " +
                                    (cart[index].item['price'] *
                                            cart[index].qty)
                                        .toString(),
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              },
            ),
          ),
          cartService.cart.length == 0
              ? Row(
                  children: [
                    Container(
                        color: kPrim,
                        height: 50,
                        width: screenWidth(context),
                        child: Center(
                            child: Text(
                          "No Items",
                          style: txColor(Colors.white)
                              .copyWith(fontWeight: FontWeight.bold),
                        )))
                  ],
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              'Total: \$' + totalPrice,
                              style: tx16.copyWith(fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          color: kPrim,
                          height: 50,
                          width: screenWidth(context),
                          child: TextButton(
                            onPressed: () {
                              //TODO: implement dummy payment
                              print(groupItemsByCompany(cartService.cart));
                              paymentService.setPaymentDetails(cart: cartService.cart);
                              paymentService.launchRazorPay(
                                cartService.totalPrice()
                              );
                              // Provider.of<DatabaseService>(context,listen: false).generateMenu();
                              // for(int i=0;i<cartService.cart.length;i++){
                              // Provider.of<DatabaseService>(context,listen: false)
                              //     .generateOrder(
                              //   restoName: cartService.cart[i].restoName,
                              //   restoId: cartService.cart[i].restoId,
                              //   day: cartService.cart[i].selectedDay,
                              //   item: cartService.cart[i].item['name'],
                              //   qty: cartService.cart[i].qty,
                              //   timeWindow: cartService.cart[i].selectedTime
                              // );
                              // }
                            },
                            child: Text(
                              "PROCEED TO PAY",
                              style: txColor(Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
        ],
      ),
    );
  }

  groupItemsByCompany(List<CartModel> cart) {
    final group = groupBy(cart, (CartModel c) {
      return c.restoName;
    });
    print(group);
  }
}
