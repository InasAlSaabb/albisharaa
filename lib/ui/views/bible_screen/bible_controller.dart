import 'package:albisharaa/core/data/models/apis/bishara_model.dart';
import 'package:albisharaa/core/data/models/apis/sefer_model.dart';
import 'package:albisharaa/core/data/reposotories/trans_repository.dart';
import 'package:albisharaa/core/enums/message_type.dart';
import 'package:albisharaa/core/enums/operation_type.dart';
import 'package:albisharaa/core/services/base_controller.dart';
import 'package:albisharaa/core/services/sql_services.dart';
import 'package:albisharaa/ui/shared/custom_widgets/custom_toast.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class BibleController extends BaseController {
  SqlDb sql = SqlDb();
  RxList<SefrModel> translist = <SefrModel>[].obs;
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
  Future<void> getTran({required String ch}) async {
    runLoadingFutureFunction(
      operationType: OperationType.TRANS,
      function: TransRepository().getAll(ch: ch).then((value) async {
        value.fold((errorMessage) {
          CustomToast.showMessage(
              message: errorMessage, messageType: MessageType.REJECTED);
        }, (result) async {
          Database? mydb = await sql.db;

          await mydb!.transaction((txn) async {
            for (var sefr in result) {
              // Insert into trans table using transaction
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
                  // Insert into chapters using transaction
                  await txn.insert('chapters',
                      {'chnr': chapter.chnr, 'sfrnr': sefr.id, 'trans': ch},
                      conflictAlgorithm: ConflictAlgorithm.replace);

                  if (chapter.verses != null) {
                    for (var verse in chapter.verses!) {
                      // Insert verses using transaction
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
                      print("okkkkkkkk");
                    }
                  }
                }
              }
            }
          });

          CustomToast.showMessage(
              message: "Succeeded", messageType: MessageType.SUCCESS);
          translist.value = result;
        });
      }),
    );
  }
}
