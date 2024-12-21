import 'package:albisharaa/core/enums/connectivity_status.dart';
import 'package:albisharaa/core/services/base_controller.dart';
import 'package:albisharaa/core/utils/general_utils.dart';

class MyAppController extends BaseController {
  //object from enum default value online
  ConnectivityStatus connectivityStatus = ConnectivityStatus.ONLINE;

  set setConnectivityStatus(ConnectivityStatus value) {
    connectivityStatus = value;
  }

  void listenForConnectivityStatus() {
    connectivityService.connectivityStatusController.stream.listen((event) {
      setConnectivityStatus = event;
    });
  }

  @override
  void onInit() {
    //first
    listenForConnectivityStatus();
    super.onInit();
  }
}
