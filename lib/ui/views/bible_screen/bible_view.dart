import 'package:albisharaa/ui/shared/colors.dart';
import 'package:albisharaa/ui/shared/custom_widgets/custom_con.dart';
import 'package:albisharaa/ui/shared/utils.dart';
import 'package:albisharaa/ui/views/bible_screen/bible_controller.dart';
import 'package:albisharaa/ui/views/m_view/m_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BibleView extends StatefulWidget {
  const BibleView({super.key});

  @override
  State<BibleView> createState() => _BibleViewState();
}

class _BibleViewState extends State<BibleView> {
  BibleController controller = Get.put(BibleController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainBackColor,
        appBar: AppBar(
          backgroundColor: AppColors.mainOrangeColor,
          leadingWidth: screenWidth(1),
          leading: Center(
              child: Text(
            'البشارة',
            style: TextStyle(fontSize: screenWidth(10), color: Colors.white),
          )),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth(6)),
          child: ListView(
            children: [
              SizedBox(
                height: screenHieght(40),
              ),
              Text(
                'اختر الترجمة',
                style: TextStyle(
                    fontSize: screenWidth(12),
                    color: AppColors.mainOrangeColor),
              ),
              SizedBox(
                height: screenHieght(50),
              ),
              InkWell(
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  );

                  await controller.getTran(ch: "M");

                  Navigator.pop(context); // إغلاق مؤشر التحميل

                  Get.to(() => MView(
                        name: "الترجمة المشتركة دار الكتاب المقدس",
                        id: "M",
                      ));
                },
                child: CustomCont(
                  text: controller.bishara.m!,
                ),
              ),
              SizedBox(
                height: screenHieght(40),
              ),
              InkWell(
                onTap: () async {
                  await controller.getTran(ch: "V");

                  Get.to(MView(
                    name: "ترجمة فاندايك",
                    id: "V",
                  ));
                },
                child: CustomCont(
                  text: controller.bishara.v!,
                ),
              ),
              SizedBox(
                height: screenHieght(40),
              ),
              InkWell(
                  onTap: () async {
                    await controller.getTran(ch: "K");
                    Get.to(MView(
                      name: "الترجمة الكاثوليكية",
                      id: "K",
                    ));
                  },
                  child: CustomCont(text: controller.bishara.k!)),
              SizedBox(
                height: screenHieght(40),
              ),
              InkWell(
                  onTap: () async {
                    await controller.getTran(ch: "P");
                    Get.to(MView(
                      name: "الترجمة البولسية",
                      id: "P",
                    ));
                  },
                  child: CustomCont(text: controller.bishara.p!)),
              SizedBox(
                height: screenHieght(40),
              ),
              InkWell(
                  onTap: () async {
                    await controller.getTran(ch: "H");
                    Get.to(MView(
                      name: "ترجمة كتاب الحياة",
                      id: "H",
                    ));
                  },
                  child: CustomCont(text: controller.bishara.h!)),
              SizedBox(
                height: screenHieght(40),
              ),
              InkWell(
                  onTap: () async {
                    await controller.getTran(ch: "SY");
                    Get.to(MView(
                      name: "النص السرياني",
                      id: "SY",
                    ));
                  },
                  child: CustomCont(text: controller.bishara.sY!)),
              SizedBox(
                height: screenHieght(40),
              ),
              InkWell(
                  onTap: () async {
                    await controller.getTran(ch: "GR");
                    Get.to(MView(
                      name: "النص اليوناني",
                      id: "GR",
                    ));
                  },
                  child: CustomCont(text: controller.bishara.gR!)),
              SizedBox(
                height: screenHieght(40),
              ),
              InkWell(
                  onTap: () async {
                    await controller.getTran(ch: "HE");
                    Get.to(MView(
                      name: "النص العبري",
                      id: "HE",
                    ));
                  },
                  child: CustomCont(text: controller.bishara.hE!)),
              SizedBox(
                height: screenHieght(40),
              ),
              InkWell(
                  onTap: () async {
                    await controller.getTran(ch: "EN");
                    Get.to(MView(
                      name: "النص الإنكليزي",
                      id: "EN",
                    ));
                  },
                  child: CustomCont(text: controller.bishara.eN!)),
              SizedBox(
                height: screenHieght(40),
              ),
              InkWell(
                  onTap: () async {
                    await controller.getTran(ch: "FR");
                    Get.to(MView(
                      name: "النص الفرنسي",
                      id: "FR",
                    ));
                  },
                  child: CustomCont(text: controller.bishara.fR!)),
            ],
          ),
        ),
      ),
    );
  }
}
