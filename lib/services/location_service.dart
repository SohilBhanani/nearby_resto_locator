
import 'package:geocoding/geocoding.dart' as gk;
import 'package:location/location.dart';
import 'package:flutter/foundation.dart';

class LocationService with ChangeNotifier{

  LocationService(){
    getLoc();
  }

  LocationData currentLocation;
  String currentAddress;

  Location location = Location();
  // bool _serviceEnabled;
  // PermissionStatus _permissionGranted;
  LocationData _locationData;

  getLoc() async {
    try{

      _locationData = await Future.any([
        location.getLocation(),
        Future.delayed(Duration(seconds: 5), () => null),
      ]);
      if (_locationData == null) {
        _locationData = await location.getLocation();
      }
      currentLocation = _locationData;

      notifyListeners();
      getAdd(_locationData);

      }catch(e){}
  }

  getAdd(LocationData loc) async {
    try {
      List<gk.Placemark> placemarks = await gk.placemarkFromCoordinates(
          loc.latitude, loc.longitude
        // 17.377600,78.454490
      );
      gk.Placemark place = placemarks[0];
      currentAddress =
      "${place.locality}, ${place.country}";
      notifyListeners();
    }catch(e){
      print("Error in getAdd(): "+e.toString());
    }
  }

}