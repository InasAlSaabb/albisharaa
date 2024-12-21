import 'package:albisharaa/core/data/models/apis/ayat_model.dart';
import 'package:albisharaa/core/data/reposotories/ayat_repository.dart';
import 'package:albisharaa/core/enums/message_type.dart';
import 'package:albisharaa/core/enums/operation_type.dart';
import 'package:albisharaa/core/enums/request_status.dart';
import 'package:albisharaa/core/services/base_controller.dart';
import 'package:albisharaa/core/services/sql_services.dart';
import 'package:albisharaa/ui/shared/custom_widgets/custom_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class AyatController extends BaseController {
  String? trans;
  int? hid;
  int? ch;

  AyatController({this.trans, this.hid, this.ch});
  final SqlDb sql = SqlDb();
  RxList<AyatModel> ayatListtt = <AyatModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData(ch: ch!);
  }

  Future<void> fetchData({required int ch}) async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      await getAyatFromDatabase();
    } else {
      await getAyatList(trans: trans ?? '', hid: hid ?? 1, ch: ch);
    }
  }

  Future<void> getAyatFromDatabase() async {
    if (hid == null || ch == null || trans == null) {
      CustomToast.showMessage(
          message: "Invalid parameters for database query.",
          messageType: MessageType.REJECTED);
      return;
    }

    final results = await sql.readmod(
      'ayat',
      // columns: ['sfrnr', 'chnr', 'trans'],
      where: '"sfrnr" = ? AND "chnr" = ? AND "trans" = ?',
      whereArgs: [hid!, ch!, trans!], // استخدم ! للتأكد من أن القيم غير فارغة
    );
    // final results = await sql.read(
    //   'ayat',
    // );

    if (results.isNotEmpty) {
      RxList<AyatModel> res = RxList<AyatModel>.from(
          results.map((item) => AyatModel.fromJson(item)).toList());
      ayatListtt.assignAll(res);
      CustomToast.showMessage(
          message: "Data loaded from local storage",
          messageType: MessageType.SUCCESS);
    } else {
      CustomToast.showMessage(
          message: "No data found in local storage.",
          messageType: MessageType.REJECTED);
    }
  }

  bool get isLoading => requestStatus.value == RequestStatus.LOADING;

  Future<void> getAyatList({
    required String trans,
    required int hid,
    required int ch,
  }) async {
    runLoadingFutureFunction(
      operationType: OperationType.AYAYT,
      function:
          AyatRepository().getAll(trans: trans, hid: hid, ch: ch).then((value) {
        value.fold((errorMessage) {
          CustomToast.showMessage(
              message: 'Check your connection',
              messageType: MessageType.REJECTED);
        }, (result) {
          CustomToast.showMessage(
              message: "Succeeded", messageType: MessageType.SUCCESS);
          ayatListtt.value = result;
        });
      }),
    );
  }
}
