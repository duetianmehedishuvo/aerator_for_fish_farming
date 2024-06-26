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

  Future<ApiResponse> updateAllData(int status, int id) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.post('updateMotor', data: {'motor_status': status, 'id': id});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
}
