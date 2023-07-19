import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class LocationProvider extends ChangeNotifier {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  //-------position object to store position details
  Position? _position;
  Position? get position => _position;

  //-------position object to store position details
  List<Placemark> _placemarks = [];

  bool _isloading = false;
  bool get isLoading => _isloading;
  void setLoader(bool val) {
    _isloading = val;
    notifyListeners();
  }

  //-----get user cordinated
  Future<void> getCurrentPosition() async {
    try {
      //-start the loader
      setLoader(true);
      //--get position details
      _position = await _determinePosition();
      notifyListeners();

      //-check if position is null or not
      if (_position != null) {
        _placemarks = await placemarkFromCoordinates(
            _position!.latitude, _position!.longitude);

        Logger().w(_placemarks.first);
      }

      //stop the loader
      setLoader(false);
    } catch (e) {
      Logger().e(e);
      //stop the loader
      setLoader(false);
    }
  }
}
