import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sohil_jd/screens/cart_screen.dart';
import 'package:sohil_jd/services/location_service.dart';

import '../components/restroCard.dart';
import '../services/database_service.dart';
import '../shared/colors.dart';
import '../shared/ui_helper.dart';
import 'menu_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Consumer<LocationService>(
          builder: (context, locate, child) => locate.currentAddress != null
              ? Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: kPrim,
                    ),
                    horizontalSpaceTiny,
                    Text(
                      Provider.of<LocationService>(context).currentAddress,
                      style: TextStyle(color: kPrim),
                    ),
                  ],
                )
              : Text(
                  'Loading...',
                  style: TextStyle(color: kPrim),
                ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen( )));
          },),
        ],
      ),
      body: Center(
          child: Consumer<LocationService>(builder: (context, locate, child) {
        return locate.currentLocation == null
            ? CircularProgressIndicator()
            : FutureBuilder(
                future: Provider.of<DatabaseService>(context)
                    .getNearbyRestro(locate.currentLocation),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MenuScreen(
                                      resto: snapshot.data[0][index]
                                          .data()),
                                ),
                              );
                            },
                            child: RestroCard(
                              name: snapshot.data[0][index].data()['name'],
                              proximity: snapshot.data[1][index],
                              rating: snapshot.data[0][index].data()['rating']
                            ),
                          );
                        },
                        itemCount: snapshot.data[0].length);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              );
      })),
    );
  }
}
