import 'package:albisharaa/core/data/models/apis/ayat_model.dart';
import 'package:albisharaa/core/enums/message_type.dart';
import 'package:albisharaa/core/enums/request_status.dart';
import 'package:albisharaa/core/services/base_controller.dart';
import 'package:albisharaa/core/services/sql_services.dart';
import 'package:albisharaa/ui/shared/custom_widgets/custom_toast.dart';
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
    getVersesFromDatabase(trans: trans!, chnr: hid!, sfrnr: ch!);
  }

  Future<void> getVersesFromDatabase(
      {required int sfrnr, required int chnr, required String trans}) async {
    // Set loading state at start
    requestStatus.value = RequestStatus.LOADING;

    try {
      // First check all verses
      final allVerses = await sql.readData('SELECT * FROM verses', []);
      print("Total verses in database: ${allVerses.length}");
      if (allVerses.isNotEmpty) {
        print("Sample verse: ${allVerses.first}");
      }

      // Then check with specific filters
      final results = await sql.readData(
          'SELECT * FROM verses WHERE sfrnr=? AND chnr=? AND trans=?',
          [hid!, ch!, trans!]);

      print("Filtered verses count: ${results.length}");
      print("Using filters: sfrnr=$hid, chnr=$ch, trans=$trans");

      if (results.isNotEmpty) {
        ayatListtt.value =
            results.map((item) => AyatModel.fromJson(item)).toList();
        CustomToast.showMessage(
            message: "تم تحميل الآيات بنجاح", messageType: MessageType.SUCCESS);
        requestStatus.value = RequestStatus.SUCCESS;
      } else {
        CustomToast.showMessage(
            message: "لم يتم العثور على آيات",
            messageType: MessageType.REJECTED);
        requestStatus.value = RequestStatus.ERROR;
      }
    } catch (e) {
      requestStatus.value = RequestStatus.ERROR;
      CustomToast.showMessage(
          message: "حدث خطأ في تحميل الآيات",
          messageType: MessageType.REJECTED);
    }
  }

  bool get isLoading => requestStatus.value == RequestStatus.LOADING;
}
