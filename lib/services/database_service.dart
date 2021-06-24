import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';

import 'package:location/location.dart';


class DatabaseService {
  final _fstore = FirebaseFirestore.instance;
  static const RADIUS = 5000;

  // for storing converted distance into minutes
  List _distancesToMins = [];

  getNearbyRestro(LocationData pos) async {
    Distance distance = Distance();
    List<QueryDocumentSnapshot> restos = [];
    try {
      QuerySnapshot<Map<String, dynamic>> p =
          await _fstore.collection('restaurants').get();
      for (int i = 0; i < p.docs.length; i++) {
        double dist = distance(
            LatLng(pos.latitude, pos.longitude),
            // LatLng(17.37760, 78.45449),
            LatLng(
              p.docs[i].data()['coords'][0],
              p.docs[i].data()['coords'][1],
            ));
        if (dist < RADIUS) {
          restos.add(p.docs[i]);
          //On average a person walks with the speed of 1.4 mtrs per second
          int proxi = (dist / 84.0).round();
          proxi.roundToDouble();
          _distancesToMins.add(proxi);
        }
        // print(dist.toString());
      }
      return [restos, _distancesToMins];
    } catch (e) {
      print("Error in getNearbyRestro(): " + e.toString());
    }
  }

  getRestoMenu(String docID) async {
    try {
      return await _fstore
          .collection('restaurants')
          .doc(docID)
          .collection('menu')
          .get();
    } catch (e) {
      print("Problem in getting the Restomenu: " + e.toString());
    }
  }

  // generateResto() async {
  //   try {
  //     for(int i = 0;i<restos.length;i++){
  //     var a = await _fstore.collection('restaurants').doc();
  //     a.set({
  //       'name': restos[i]['name'],
  //       'rating': "4.5",
  //       'restoid': a.id,
  //       'timeFrom': '2020-05-07 11:00:04Z',
  //       'timeTo': '2020-05-07 19:00:04Z',
  //       'days': ["Wed", "Thu", "Fri"],
  //       'coords': restos[i]['coords']
  //     });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // generateMenu() async {
  //   try {
  //     var a = await _fstore
  //         .collection('restaurants')
  //         .doc("deqeY5Q26NRlbz8CaPFG")
  //         .collection('menu')
  //         .doc();
  //     a.set({
  //       'category': "Preorder Available",
  //       'cuisine': 'vegan',
  //       'images': [
  //         'https://cdn.shopify.com/s/files/1/0302/0714/8116/products/WhatsApp_Image_2021-05-07_at_11.24.26_720x.jpg?v=1620359259',
  //         'https://cdn.shopify.com/s/files/1/0302/0714/8116/products/WhatsAppImage2021-03-15at09.56.44_720x.jpg?v=1617448267',
  //         'https://cdn.shopify.com/s/files/1/0302/0714/8116/products/WhatsAppImage2021-03-15at09.56.45_720x.jpg?v=1617448272'
  //       ],
  //       'itemid': a.id,
  //       'name': 'Bakery and Desert',
  //       'price': 3.9,
  //       'rating': 2.5
  //     });
  //     print("Menu Generated");
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  generateOrder(
      {String restoName,
      String restoId,
      String item,
      int qty,
      DateTime timeWindow,
      String day}) async {
    try {
      return await _fstore.collection('orders').doc().set({
        'restoId': restoId,
        'userId': '123456789',
        'username': 'Mr. Dummy',
        'email': 'dummy@dummy.com',
        'retaurantName': restoName,
        'items': item,
        'qty': qty,
        'timeWindow': timeWindow.toString(),
        'day': day,
      }).then((value) => print('Order Generated'));
    } catch (e) {
      print("Error in placing order generateOrder(): " + e.toString());
    }
  }
}
