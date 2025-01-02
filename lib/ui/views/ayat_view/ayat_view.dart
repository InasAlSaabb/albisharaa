import 'package:albisharaa/ui/shared/colors.dart';
import 'package:albisharaa/ui/shared/utils.dart';
import 'package:albisharaa/ui/views/ayat_view/ayat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class AyatView extends StatefulWidget {
  const AyatView({super.key, this.trans, this.hid, this.ch});
  final String? trans;
  final int? hid;
  final int? ch;

  @override
  State<AyatView> createState() => _AyatViewState();
}

class _AyatViewState extends State<AyatView> {
  late AyatController controllerr;

  Future<bool> checkAndInsert(int id, Map<String, dynamic> data) async {
    if (!await controllerr.sql.recordExists('ayat', id)) {
      await controllerr.sql.insert('ayat', data);
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    controllerr = Get.put(
        AyatController(trans: widget.trans, hid: widget.hid, ch: widget.ch));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.mainBackColor,
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth(40)),
                child: Stack(children: [
                  Obx(() {
                    return controllerr.isLoading
                        ? SpinKitCircle(
                            color: AppColors.mainOrangeColor,
                          )
                        : ListView(
                            shrinkWrap: true,
                            children: [
                              SizedBox(height: screenHieght(60)),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controllerr.ayatListtt.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final ayat = controllerr.ayatListtt[index];

                                  return Visibility(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.mainBackColor,
                                      ),
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {},
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (ayat.tid != null)
                                                Center(
                                                  child: Text(
                                                    ayat.tid!,
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .mainOrangeColor,
                                                      fontSize: screenWidth(13),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                          width:
                                                              screenWidth(18)),
                                                      Text(
                                                        "${ayat.vnumber ?? ""}:", // إضافة الرقم هنا
                                                        style: TextStyle(
                                                          fontSize:
                                                              screenWidth(20),
                                                          color: const Color
                                                              .fromRGBO(
                                                              75, 52, 43, 1),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      width: screenWidth(
                                                          16)), // مساحة بين الرقم والنص
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          ayat.textch ??
                                                              "", // استخدم قيمة افتراضية
                                                          style: TextStyle(
                                                            fontSize:
                                                                screenWidth(20),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: AppColors
                                                                .mainOrangeColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                  }),
                  Positioned(
                    top: screenHieght(1.1),
                    // bottom: 0,
                    // bottom: 0,
                    child: Row(children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // تحديث قيمة controllerr.ch قبل تمريرها
                            controllerr.ch = (controllerr.ch! - 1)
                                .clamp(1, double.infinity)
                                .toInt(); // تأكد من أن القيمة لا تقل عن 1
                            controllerr.getVersesFromDatabase(
                                chnr: controllerr.ch!,
                                sfrnr: controllerr.hid!,
                                trans: controllerr.trans!);
                          });
                        },
                        child: Text(
                          "السابق",
                          style: TextStyle(
                            fontSize: screenWidth(20),
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(140, 50),
                          backgroundColor: AppColors.mainOrangeColor,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth(4),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // تحديث قيمة controllerr.ch قبل تمريرها
                            controllerr.ch = (controllerr.ch! + 1).toInt();
                            controllerr.getVersesFromDatabase(
                                chnr: controllerr.ch!,
                                sfrnr: controllerr.hid!,
                                trans: controllerr.trans!);
                          });
                        },
                        child: Text(
                          "التالي",
                          style: TextStyle(
                            fontSize: screenWidth(20),
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(140, 50),
                          backgroundColor: AppColors.mainOrangeColor,
                        ),
                      ),
                    ]),
                  )
                ]))));
  }
}
