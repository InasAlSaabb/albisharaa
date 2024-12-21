import 'package:albisharaa/core/data/models/apis/sefer_model.dart';
import 'package:albisharaa/core/data/models/common_response.dart';
import 'package:albisharaa/core/data/network/endpoints/trans_endpoints.dart';
import 'package:albisharaa/core/data/network/network_config.dart';
import 'package:albisharaa/core/enums/request_type.dart';
import 'package:albisharaa/core/utils/network_util.dart';
import 'package:dartz/dartz.dart';

class TransRepository {
  Future<Either<String, List<SefrModel>>> getAll({required String ch}) async {
    try {
      final response = await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: TranEndpoints.getAll + ch,
        headers:
            NetworkConfig.getHeaders(needAuth: false, type: RequestType.GET),
      );

      CommonResponse<dynamic> commonResponse =
          CommonResponse.fromJson(response);

      if (commonResponse.getStatus) {
        List<SefrModel> result = [];

        commonResponse.data['asfar']!.forEach(
          (element) {
            result.add(SefrModel.fromJson(element));
          },
        );
        return Right(result);
      } else {
        return Left(commonResponse.message ?? '');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
