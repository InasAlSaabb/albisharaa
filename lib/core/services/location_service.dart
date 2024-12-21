import 'package:albisharaa/ui/shared/custom_widgets/custom_toast.dart';
import 'package:albisharaa/ui/shared/utils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart';

import '../../app/app_config.dart';

class LocationService {
  Location location = Location();

  Future<LocationData?> getUserCurrentLocation({bool hideLoader = true}) async {
    LocationData locationData;

    if (!await isLocationEnabeld()) {
      return null;
    }

    if (!await isPermissionGranted()) {
      return null;
    }

    customLoader();

    locationData = await location.getLocation();

    if (hideLoader) BotToast.closeAllLoading();

    return locationData;
  }

  Future<geo.Placemark?> getAddressInfo(LocationData locationData,
      {bool showLoader = true}) async {
    if (showLoader) customLoader();

    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);

    BotToast.closeAllLoading();

    if (placemarks.isNotEmpty) {
      CustomToast.showMessage(message: placemarks[0].country.toString());

      return placemarks[0];
    } else {
      return null;
    }
  }

  Future<geo.Placemark?> getCurrentAddressInfo() async {
    LocationData loc = await getUserCurrentLocation(hideLoader: false) ??
        LocationData.fromMap({});
    return await getAddressInfo(loc, showLoader: false)
        .then((value) => CustomToast.showMessage(message: ''));
  }

  Future<bool> isLocationEnabeld() async {
    bool serviceEnabled;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        if (AppConfig.isLocationRequired) {
          CustomToast.showMessage(message: 'enable the location');
        }
        return false;
      }
    }

    return serviceEnabled;
  }

  Future<bool> isPermissionGranted() async {
    PermissionStatus permissionGranted;

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        if (AppConfig.isLocationRequired) {
          CustomToast.showMessage(message: 'location is required');
        }

        return false;
      }
    }

    return permissionGranted == PermissionStatus.granted;
  }
}
