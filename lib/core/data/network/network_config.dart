//ملف الاعدادادتى لكامل ال api
import 'package:albisharaa/core/enums/request_type.dart';
import 'package:albisharaa/core/utils/general_utils.dart';

class NetworkConfig {
  static String BASE_API = "/api/";
//albishara.net/api/asfar/list/{trans}/
  static String getFullApiRoute(String apiroute) {
    return BASE_API + apiroute;
  }

  static Map<String, String>? getHeaders(
      {bool needAuth = true,
      RequestType? type,
      Map<String, String>? extraHeaders}) {
    return {
      if (needAuth)
        "Authorization": "Bearer ${storage.getTokenInfo()?.accessToken ?? ''}",
      if (type != RequestType.GET)
        "Content-Type": type == RequestType.MULTIPART
            ? "multipart/form-data"
            : "application/json",
      ...extraHeaders ?? {}
    };
  }
}
