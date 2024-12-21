import 'package:albisharaa/ui/shared/colors.dart';
import 'package:albisharaa/ui/shared/utils.dart';
import 'package:albisharaa/ui/views/splash_screen/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashSceenView extends StatefulWidget {
  const SplashSceenView({super.key});
  @override
  State<SplashSceenView> createState() => _SplashSceenViewState();
}

class _SplashSceenViewState extends State<SplashSceenView> {
  SplashSceenController controller = Get.put(SplashSceenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.mainBackColor,
            body: Stack(
              alignment: Alignment.bottomCenter,
              fit: StackFit.passthrough,
              children: [
                Center(
                    child: SvgPicture.asset(
                  'assets/images/Logo-abdo-1.svg',
                  width: screenWidth(4),
                  height: screenHieght(4),
                )),
                Container(
                  margin: EdgeInsets.only(bottom: screenWidth(3)),
                  height: screenWidth(3),
                  child: SpinKitThreeBounce(
                    color: Color.fromARGB(255, 215, 207, 149),
                  ),
                ),
              ],
            )));
  }
}
