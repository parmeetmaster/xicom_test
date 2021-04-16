import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:xicom_test/api/DioInstance.dart';
import 'package:xicom_test/model/image_model.dart';
import 'package:http/http.dart' as http;
import 'package:xicom_test/utils/toast.dart';
import 'package:xicom_test/utils/validation.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path/path.dart' as p;
class FormScreenProvider extends ChangeNotifier {
  TextEditingController firstname = new TextEditingController();

  TextEditingController lastname = new TextEditingController();

  TextEditingController email = new TextEditingController();

  TextEditingController phoneNumber = new TextEditingController();
  GlobalKey<ScaffoldState> key;
  ImageData data;
  String url;
  String filename;
  var dataBytes;

  reset(){
     firstname = new TextEditingController();

     lastname = new TextEditingController();

     email = new TextEditingController();

     phoneNumber = new TextEditingController();

  }

  submit() async {
    if (firstname.text.isEmpty ||
        lastname.text.isEmpty ||
        email.text.isEmpty ||
        phoneNumber.text.isEmpty) {
      toast(key, "All fields are required");
      return;
    }

    if (Validation().isEmailValid(email.text) == false) {
      toast(key, "Email format invalid");
      return;
    }

    if (Validation().isPhoneNumberValid(phoneNumber.text) == false) {
      toast(key, "Phone number format invalid");
      return;
    }

    Dio dio = ApiService().getclient();
    File uploadImage = await downloadImage(data.xtImage);



    FormData formData = FormData.fromMap({
      "first_name": firstname.text,
      "last_name": lastname.text,
      "email": email.text,
      "phone": phoneNumber.text,
      "user_image": await MultipartFile.fromFile(uploadImage.path,filename: p.basename(uploadImage.path))
    });

    Response response = await dio.post("/savedata.php", data: formData);
    if (response.statusCode == 200) {
      toast(key, "upload successful");
    }
  }

  downloadImage(String url) async {
    Uuid uuid = Uuid();
    String save_file_name=uuid.v4();
    var response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: save_file_name);

    Directory appDocDir = await getExternalStorageDirectory();
    String appDocPath = appDocDir.path;
    print(appDocPath);

    File file=  File("/storage/emulated/0/xicom_test/${save_file_name}.jpg");
    print(result);


    return file;
  }

  loadImages(String url) async {
    var file = await DefaultCacheManager().getSingleFile(url);
  return file;
  }

}
