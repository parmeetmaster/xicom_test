import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xicom_test/api/DioInstance.dart';
import 'package:xicom_test/constants/constants.dart';
import 'package:xicom_test/model/image_model.dart';

class HomeProvider extends ChangeNotifier {
  int page_index = 0;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List<ImageData> listImage;
  dynamic currunt_state = app_state.init;

  init() {
    listImage=[];
    loadPage();
  }

  loadPage() async {

    Dio dio = ApiService().getclient();
    var form = FormData.fromMap({
      "user_id": "108",
      "offset": "${page_index}",
      "type": "popular",
    });


    try {
      Response response = await dio.post("/getdata.php", data: form);
      ImageDataModel obj= ImageDataModel.fromJson(jsonDecode(response.data)) ;
        if(obj==null || obj.images==null || obj.images.isEmpty){
          return;
        }

      listImage.addAll(obj.images);
    } on DioError catch (e) {
    }

    notifyListeners();

  }

  void referesh() {
    listImage=[];
    page_index=0;
    loadPage();
   refreshController.refreshCompleted();
    notifyListeners();

  }

  void onLoading() async {

    ++page_index;
   await loadPage();
   try {
     refreshController.loadComplete();
   }catch(e){}
  }
}
