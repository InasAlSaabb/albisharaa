import 'package:albisharaa/main.dart';
import 'package:albisharaa/ui/shared/colors.dart';
import 'package:albisharaa/ui/shared/utils.dart';
import 'package:albisharaa/ui/views/ayat_view/ayat_view.dart';
import 'package:albisharaa/ui/views/chnr_view/chnr_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChnrView extends StatefulWidget {
  const ChnrView({super.key, this.ch, this.hid, this.trans, this.name});
  final int? ch;
  final int? hid;
  final String? trans;
  final String? name;

  @override
  State<ChnrView> createState() => _ChnrViewState();
}

class _ChnrViewState extends State<ChnrView> {
  late ChnrController controllerr;
  @override
  void initState() {
    controllerr = Get.put(
        ChnrController(ch: widget.ch, hid: widget.hid, trans: widget.trans));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.mainOrangeColor,
              leadingWidth: screenWidth(1),
              leading: Center(
                  child: Text(
                widget.name!,
                style:
                    TextStyle(fontSize: screenWidth(14), color: Colors.white),
              )),
            ),
            backgroundColor: AppColors.mainBackColor,
            body: ListView(shrinkWrap: true, children: [
              screenHieght(15).ph,
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100),
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: controllerr.ch,
                  itemBuilder: (BuildContext context, int index) {
                    index++;
                    return InkWell(
                      onTap: () {
                        Get.to(AyatView(
                          ch: index,
                          trans: widget.trans,
                          hid: widget.hid,
                        ));
                      },
                      child: Container(
                        width: screenWidth(5),
                        decoration: BoxDecoration(
                            color: AppColors.mainOrangeColor,
                            border:
                                Border.all(color: AppColors.mainWhiteColor)),
                        child: Center(
                            child: Text(
                          index.toString(),
                          style: TextStyle(
                              color: AppColors.mainBackColor,
                              fontSize: screenWidth(20),
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    );
                  }),
            ])));
  }
}
