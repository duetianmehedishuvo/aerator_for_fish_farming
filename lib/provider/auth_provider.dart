import 'package:flutter/material.dart';
import 'package:women_safety/data/model/response/base/api_response.dart';
import 'package:women_safety/data/model/response/orginal_data_model.dart';
import 'package:women_safety/data/repository/splash_repo.dart';

class AuthProvider with ChangeNotifier {
  final SplashRepo splashRepo;

  AuthProvider({required this.splashRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  OrginalDataModel orginalDataModel = OrginalDataModel();

  Future<OrginalDataModel> getAllData() async {
    _isLoading = true;
    ApiResponse response = await splashRepo.getAllData();
    _isLoading = false;

    if (response.response.statusCode == 200) {
      orginalDataModel = OrginalDataModel.fromJson(response.response.data);
    } else {
      print(response.response.statusMessage!);
      // Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
    return orginalDataModel;
  }

  void updateAllData(int status) async {
    _isLoading = true;
    OrginalDataModel o = orginalDataModel;
    o.motorStatus = status;
    ApiResponse response = await splashRepo.updateAllData(o);
    _isLoading = false;

    if (response.response.statusCode == 200) {
      // orginalDataModel = OrginalDataModel.fromJson(response.response.data);
    } else {
      print(response.response.statusMessage!);
      // Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
    // return orginalDataModel;
  }
}
