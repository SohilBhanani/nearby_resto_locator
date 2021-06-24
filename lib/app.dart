import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sohil_jd/services/payment_service.dart';

import 'shared/colors.dart';
import 'screens/home_screen.dart';

import 'services/location_service.dart';
import 'services/database_service.dart';
import 'services/cart_service.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocationService>(
          create: (_) => LocationService(),
        ),
        Provider<DatabaseService>(
          create: (_) => DatabaseService(),
        ),
        ChangeNotifierProvider<CartService>(
          create: (_) => CartService(),
        ),
        ChangeNotifierProvider<PaymentService>(
          create: (_) => PaymentService(),
        )
      ],
      child: MaterialApp(
          theme: ThemeData(
              primaryColor: kPrim,
              buttonTheme: ButtonThemeData(
                  buttonColor: kPrim, textTheme: ButtonTextTheme.primary),
              iconTheme: IconThemeData(
                color: kPrim, //change your color here
              ),
              appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(
                    color: kPrim, //change your color here
                  ),
                  elevation: 0,
                  // titleTextStyle: TextStyle(color: kPrim),
                  // textTheme: TextTheme(bodyText1: TextStyle(color: kPrim) ),
                  color: Colors.transparent,
                  actionsIconTheme: IconThemeData(color: kPrim)),
              primaryTextTheme:
                  Theme.of(context).primaryTextTheme.apply(bodyColor: kPrim)),
          home: HomeScreen()),
    );
  }
}
