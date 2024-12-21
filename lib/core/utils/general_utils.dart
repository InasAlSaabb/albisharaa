import 'package:albisharaa/app/my_app_controller.dart';
import 'package:albisharaa/core/data/reposotories/shared_prefernces.dart';
import 'package:albisharaa/core/enums/connectivity_status.dart';
import 'package:albisharaa/core/enums/message_type.dart';
import 'package:albisharaa/core/services/connectivity_service.dart';
import 'package:albisharaa/ui/shared/custom_widgets/custom_toast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

ConnectivityService get connectivityService => Get.find<ConnectivityService>();

SharedPrefrenceRepostory get storage => Get.find<SharedPrefrenceRepostory>();
Future claunchUrl(Uri url) async {
  if (!await launchUrl(
    url,
    // mode: LaunchMode.externalApplication,
  )) {
    CustomToast.showMessage(
        message: 'cant launch url', messageType: MessageType.REJECTED);
  }
}

double get taxAmount => 0.18;
double get deliverAmount => 0.1;
//when value change change
bool get isOnline =>
    Get.find<MyAppController>().connectivityStatus == ConnectivityStatus.ONLINE;

bool get isOffline =>
    Get.find<MyAppController>().connectivityStatus ==
    ConnectivityStatus.OFFLINE;
//return note
//func bool and  toast
void checkConnection(Function function) {
  if (isOnline)
    //easy
    function();
  else
    showNoConnectionMessage();
}

void showNoConnectionMessage() {
  CustomToast.showMessage(
      message: 'Please check internet connection',
      messageType: MessageType.WARNING);
}
