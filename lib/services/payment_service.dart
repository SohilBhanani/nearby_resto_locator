// keyId: rzp_test_2FG5o7bA1tujWj
// keySecret: ejhie18iXd57eHT42ZHiDsby

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sohil_jd/model/cart_model.dart';
import 'package:sohil_jd/services/database_service.dart';
import 'package:sohil_jd/shared/colors.dart';

class PaymentService with ChangeNotifier {
  var _razorpay;
  String paymentStatus = 'initial';
  String itemId;
  var item;
  DateTime selectedTime;
  String selectedDay;
  int qty;
  String restoId;
  String restoName;
  List<CartModel> cart;

  PaymentService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void setPaymentDetails({List<CartModel> cart}) {
    // this.item = item;
    // this.selectedTime = selectedTime;
    // this.selectedDay = selectedDay;
    // this.qty = qty;
    // this.restoId = restoId;
    // this.restoName = restoName;
    this.cart = cart;
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Razorpay:success----------- ${response.paymentId}');
    paymentStatus = 'successful';
    // notifyListeners();
    for (int i = 0; i < cart.length; i++) {
      DatabaseService().generateOrder(
        item: cart[i].item['name'],
        timeWindow: cart[i].selectedTime,
        restoId: cart[i].restoId,
        restoName: cart[i].restoName,
        day: cart[i].selectedDay,
        qty: cart[i].qty,
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Razorpay:error');
    paymentStatus = 'failure';
    notifyListeners();
    Fluttertoast.showToast(
        msg: 'Payment Failed: Please Try Again Later', backgroundColor: kRed);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('Razorpay:external Wallet');
    paymentStatus = 'external_wallet';
    notifyListeners();
  }

  launchRazorPay(amount) {
    var options = {
      'key': 'rzp_test_2FG5o7bA1tujWj',
      'amount': amount * 100,
      'name': 'Just Dabao',
      'description': ' Online Payment',
      'prefill': {'contact': 9898542112, 'email': 'test@gmail.com'},
      // 'external': {
      //   'wallets': ['paytm']
      // }
    };

    _razorpay.open(options);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
}
