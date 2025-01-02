import 'package:albisharaa/core/data/models/apis/list_asfar_model.dart';
import 'package:albisharaa/ui/shared/colors.dart';
import 'package:albisharaa/ui/shared/utils.dart';
import 'package:albisharaa/ui/views/bible_screen/bible_controller.dart';
import 'package:albisharaa/ui/views/chnr_view/chnr_view.dart';
import 'package:albisharaa/ui/views/m_view/m_controller.dart';
import 'package:albisharaa/ui/views/search_view/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class MView extends StatefulWidget {
  const MView({super.key, this.id, this.tp, this.name});
  final String? id;
  final String? name;

  final int? tp;
  @override
  State<MView> createState() => _MViewState();
}

class _MViewState extends State<MView> {
  late Mcontroller controllerr;
  BibleController cc = Get.put(BibleController());
  Future<bool> checkAndInsert(int id, Map<String, dynamic> data) async {
    if (!await controllerr.sql.recordExists('asfar', id)) {
      await controllerr.sql.insert('asfar', data);
      return true;
    }
    return false;
  }

  @override
  void initState() {
    controllerr =
        Get.put(Mcontroller(id: widget.id, name: widget.name, tp: widget.tp));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainOrangeColor,
        leadingWidth: screenWidth(1),
        leading: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: screenWidth(8),
              ), // أيقونة البحث
              onPressed: () {
                Get.to(ArabicSearchView(
                  sss: cc.translist
                      .map((item) =>
                          asfarListModel(name: item.name, id: item.id))
                      .toList(),
                ));
                // هنا يمكنك إضافة الكود الذي يقوم بفتح صفحة البحث أو تنفيذ أي إجراء
                print('بحث تم الضغط عليه');
              },
            ),
            Center(
              child: Text(
                widget.name!,
                style:
                    TextStyle(fontSize: screenWidth(16), color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.mainBackColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth(40)),
        child: Obx(() {
          return controllerr.isLoading
              ? SpinKitCircle(
                  color: AppColors.mainOrangeColor,
                )
              : Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("العهد القديم",
                              style: TextStyle(
                                  fontSize: screenWidth(12),
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainOrangeColor)),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cc.translist.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (cc.translist[index].tp != 1) {
                                  return SizedBox.shrink();
                                }
                                return buildListItem(index);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(
                      width: 40,
                      thickness: 2,
                      color: Colors.brown,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("العهد الجديد",
                              style: TextStyle(
                                  fontSize: screenWidth(12),
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainOrangeColor)),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cc.translist.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (cc.translist[index].tp != 2) {
                                  return SizedBox.shrink();
                                }
                                return buildListItem(index);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        }),
      ),
    ));
  }

  Widget buildListItem(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHieght(100)),
      child: Container(
        padding: EdgeInsets.only(bottom: screenHieght(60)),
        decoration: BoxDecoration(
          color: AppColors.mainBackColor,
          border: Border(
            bottom: BorderSide(
              style: BorderStyle.solid,
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
        child: Center(
          child: InkWell(
            onTap: () {
              Get.to(ChnrView(
                name: cc.translist[index].name,
                trans: widget.id,
                hid: cc.translist[index].id,
                ch: cc.translist[index].chrcnt,
              ));
            },
            child: Text(
              cc.translist[index].name ?? "",
              style: TextStyle(
                  fontSize: screenWidth(22),
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainOrangeColor),
            ),
          ),
        ),
      ),
    );
  }
}
