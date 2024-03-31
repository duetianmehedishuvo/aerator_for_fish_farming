import 'package:dio/dio.dart';
import 'package:women_safety/data/datasource/remote/dio/dio_client.dart';
import 'package:women_safety/data/datasource/remote/exception/api_error_handler.dart';
import 'package:women_safety/data/model/response/base/api_response.dart';
import 'package:women_safety/data/model/response/orginal_data_model.dart';
import 'package:women_safety/util/app_constant.dart';

class SplashRepo {
  final DioClient dioClient;

  SplashRepo({required this.dioClient});

  Future<ApiResponse> getAllData() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get(AppConstant.getAllData);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> updateAllData(OrginalDataModel orginalDataModel) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get(
          'updateData?adcTemperature=121&adcVoltage=${orginalDataModel.adcVoltage}&do=${orginalDataModel.do1}&motorStatus=${orginalDataModel.motorStatus}&phValue=${orginalDataModel.phValue}&phVoltage=${orginalDataModel.phVoltage}&temperatureC=${orginalDataModel.temperatureC}&temperatureF=${orginalDataModel.temperatureF}&id=${orginalDataModel.id}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
}
