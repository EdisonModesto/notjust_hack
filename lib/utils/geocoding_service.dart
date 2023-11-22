import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';

class GeocodingService {
  Future<String> getAddressFromGeoPoint(GeoPoint geoPoint) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(geoPoint.latitude, geoPoint.longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String street = placemark.street ?? '';
        String city = placemark.locality ?? '';
        String country = placemark.country ?? '';
        return '$street, $city, $country';
      } else {
        return '';
      }
    } catch (e) {
      print('Error getting address: $e');
      return '';
    }
  }
}
