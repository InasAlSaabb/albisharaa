import 'package:albisharaa/ui/views/bible_screen/bible_view.dart';
import 'package:get/get.dart';

class SplashSceenController extends GetxController {
  @override
  void onInit() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      Get.to(BibleView());
    });
    super.onInit();
  }
}
