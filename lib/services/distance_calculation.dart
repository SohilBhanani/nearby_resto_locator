// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong/latlong.dart';
// import 'package:sohil_jd/services/user_location_service.dart';
//
// List<dynamic> data = [
//   {
//     //tgb
//     "name": "Nadi Gate",
//     "lat": 21.484452,
//     "lon": 70.958519,
//   },
//   {
//     //hilton
//     "name": "Vahi msjid",
//     "lat": 21.482409,
//     "lon": 70.953919,
//   },
//   {
//     //borito
//     "name": "Nimavat",
//     "lat": 21.484296,
//     "lon": 70.953222,
//   },
//   {
//     "name": "Savaliya",
//     "lat": 21.485244,
//     "lon": 70.949689,
//   },
//   {
//     "name": "Bhaliya",
//     "lat": 21.488924,
//     "lon": 70.954204,
//   },
//   {
//     "name": "Shivam",
//     "lat": 21.483198,
//     "lon": 70.951128,
//   },
//   {
//     "name": "Jumma msjd",
//     "lat": 21.484602,
//     "lon": 70.957989,
//   }
// ];
//
// class DistanceCalc {
// // UserLocationService loc = UserLocationService();
//
//   calculateDistance(Position loc) {
//     final Distance distance = Distance();
//     List<double> a = [];
//     print(loc.toString());
//
//     for (int i=0 ; i<data.length; i++) {
//       double dist = distance(
//         LatLng(loc.latitude, loc.longitude),
//         LatLng(data[i]["lat"], data[i]["lon"]),
//       );
//       a.add(dist);
//     }
//     print(a);
//   }
// }
