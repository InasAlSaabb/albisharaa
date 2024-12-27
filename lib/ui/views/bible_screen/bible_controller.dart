import 'package:albisharaa/core/data/models/apis/bishara_model.dart';
import 'package:albisharaa/core/data/models/apis/chapter_model.dart';
import 'package:albisharaa/core/data/models/apis/sefer_model.dart';
import 'package:albisharaa/core/data/models/apis/versemodel.dart';
import 'package:albisharaa/core/data/reposotories/trans_repository.dart';
import 'package:albisharaa/core/enums/message_type.dart';
import 'package:albisharaa/core/services/base_controller.dart';
import 'package:albisharaa/core/services/sql_services.dart';
import 'package:albisharaa/ui/shared/custom_widgets/custom_toast.dart';
import 'package:albisharaa/ui/views/load.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

class BibleController extends BaseController {
  SqlDb sql = SqlDb();
  RxList<SefrModel> translist = <SefrModel>[].obs;
  RxBool isLoadingg = false.obs;
  RxString loadingMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    verifyDatabaseTables();
  }

  bisharaModel bishara = bisharaModel(
      m: "الترجمة المشتركة دار الكتاب المقدس",
      v: "ترجمة فاندايك",
      k: "الترجمة الكاثوليكية",
      p: "الترجمة البولسية",
      h: "ترجمة كتاب الحياة",
      sY: "النص السرياني",
      gR: "النص اليوناني",
      hE: "النص العبري",
      eN: "النص الإنكليزي",
      fR: "النص الفرنسي");

  Future<void> verifyDatabaseTables() async {
    Database? mydb = await sql.db;
    var tables = await mydb!
        .query('sqlite_master', where: 'type = ?', whereArgs: ['table']);
    print('Available tables: ${tables.map((t) => t['name']).toList()}');
  }

  Future<bool> checkInternetConnection() async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      return false;
    }
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void showLoader(String message) {
    loadingMessage.value = message;
    isLoadingg.value = true;
    Get.dialog(
      PopScope(
        canPop: false,
        child: Obx(() => LoadingWidget(message: loadingMessage.value)),
      ),
      barrierDismissible: false,
    );
  }

  void hideLoader() {
    isLoadingg.value = false;
    Get.back();
  }

  Future<List<SefrModel>> getOfflineData(String ch) async {
    Database? mydb = await sql.db;
    List<SefrModel> seferList = [];

    var transRecords = await mydb!.query(
      'trans',
      where: 'trans = ?',
      whereArgs: [ch],
    );

    print('Found ${transRecords.length} trans records');

    for (var transRecord in transRecords) {
      var chapters = await mydb.query(
        'chapters',
        where: 'sfrnr = ? AND trans = ?',
        whereArgs: [transRecord['id'], ch],
      );

      print('Found ${chapters.length} chapters for trans ${transRecord['id']}');

      List<ChapterModel> chaptersList = [];
      for (var chapter in chapters) {
        var verses = await mydb.query(
          'verses',
          where: 'sfrnr = ? AND chnr = ? AND trans = ?',
          whereArgs: [transRecord['id'], chapter['chnr'], ch],
        );

        print('Found ${verses.length} verses for chapter ${chapter['chnr']}');

        var versesList = verses.map((v) => VerseModel.fromJson(v)).toList();

        chaptersList.add(ChapterModel(
          chnr: chapter['chnr'] as int,
          verses: versesList,
        ));
      }

      seferList.add(SefrModel(
        id: transRecord['id'] as int,
        name: transRecord['name'] as String,
        tp: transRecord['tp'] as int,
        basl: transRecord['basl'] as String,
        chrcnt: transRecord['chrcnt'] as int,
        chapters: chaptersList,
      ));
    }

    print('Returning ${seferList.length} sefer records');
    return seferList;
  }

  Future<void> getTran({required String ch}) async {
    try {
      showLoader('جاري التحقق من الاتصال...');
      bool hasInternet = await checkInternetConnection();

      if (hasInternet) {
        loadingMessage.value = 'جاري تحميل البيانات من الإنترنت...';

        return await TransRepository().getAll(ch: ch).then((value) async {
          return value.fold((errorMessage) async {
            loadingMessage.value = 'جاري استرجاع البيانات المحفوظة...';

            try {
              translist.value = await getOfflineData(ch);
              hideLoader();

              if (translist.isNotEmpty) {
                CustomToast.showMessage(
                    message: "تم استرجاع البيانات المحفوظة",
                    messageType: MessageType.SUCCESS);
              } else {
                CustomToast.showMessage(
                    message: errorMessage, messageType: MessageType.REJECTED);
              }
            } catch (e) {
              hideLoader();
              CustomToast.showMessage(
                  message: "حدث خطأ في استرجاع البيانات",
                  messageType: MessageType.REJECTED);
            }
          }, (result) async {
            loadingMessage.value = 'جاري حفظ البيانات...';

            Database? mydb = await sql.db;
            await mydb!.transaction((txn) async {
              int progress = 0;
              int total = result.length;

              for (var sefr in result) {
                progress++;
                loadingMessage.value =
                    'جاري حفظ البيانات... ${(progress / total * 100).toInt()}%';

                await txn.insert(
                    'trans',
                    {
                      'id': sefr.id,
                      'name': sefr.name,
                      'tp': sefr.tp,
                      'basl': sefr.basl,
                      'chrcnt': sefr.chrcnt,
                      'trans': ch
                    },
                    conflictAlgorithm: ConflictAlgorithm.replace);

                if (sefr.chapters != null) {
                  for (var chapter in sefr.chapters!) {
                    await txn.insert('chapters',
                        {'chnr': chapter.chnr, 'sfrnr': sefr.id, 'trans': ch},
                        conflictAlgorithm: ConflictAlgorithm.replace);

                    if (chapter.verses != null) {
                      for (var verse in chapter.verses!) {
                        await txn.insert(
                            'verses',
                            {
                              'id': verse.id,
                              'sfrnr': verse.sfrnr,
                              'hid': verse.hid,
                              'chnr': verse.chnr,
                              'vnumber': verse.vnumber,
                              'textch': verse.textch,
                              'tid': verse.tid,
                              'trans': ch
                            },
                            conflictAlgorithm: ConflictAlgorithm.replace);
                      }
                    }
                  }
                }
              }
            });
            translist.value = result;
            Get.forceAppUpdate();
            hideLoader();
            CustomToast.showMessage(
                message: "تم تحديث البيانات بنجاح",
                messageType: MessageType.SUCCESS);
          });
        });
      } else {
        loadingMessage.value = 'جاري استرجاع البيانات المحفوظة...';

        translist.value = await getOfflineData(ch);
        // After setting translist.value = result
        translist.refresh();

        hideLoader();

        if (translist.isNotEmpty) {
          CustomToast.showMessage(
              message: "تم استرجاع البيانات المحفوظة",
              messageType: MessageType.SUCCESS);
        } else {
          CustomToast.showMessage(
              message: "لا توجد بيانات محفوظة",
              messageType: MessageType.REJECTED);
        }
      }
    } catch (e) {
      hideLoader();
      CustomToast.showMessage(
          message: "حدث خطأ غير متوقع", messageType: MessageType.REJECTED);
    }
  }
}
