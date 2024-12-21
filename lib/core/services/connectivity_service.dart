import 'dart:async';

import 'package:albisharaa/core/enums/connectivity_status.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  //type
  StreamController<ConnectivityStatus> connectivityStatusController =
      StreamController<ConnectivityStatus>.broadcast();
//constructer
  ConnectivityService() {
    //package
    final Connectivity connectivity = Connectivity();
//feature in package
//on listen to change
    connectivity.onConnectivityChanged.listen((event) {
      //feature in controller
      connectivityStatusController.add(getStatus(event as ConnectivityResult));
    });
  }

  ConnectivityStatus getStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.bluetooth:
        return ConnectivityStatus.ONLINE;

      case ConnectivityResult.wifi:
        return ConnectivityStatus.ONLINE;
      case ConnectivityResult.ethernet:
        //web
        return ConnectivityStatus.ONLINE;
      case ConnectivityResult.mobile:
        return ConnectivityStatus.ONLINE;
      case ConnectivityResult.none:
        return ConnectivityStatus.OFFLINE;
      case ConnectivityResult.vpn:
        return ConnectivityStatus.ONLINE;
      case ConnectivityResult.other:
        return ConnectivityStatus.ONLINE;
    }
  }
}
