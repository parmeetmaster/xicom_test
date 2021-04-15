


import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../utils/app_logger.dart';


const webServiceURL="http://dev1.xicom.us/xttest";

class LogInterceptors extends Interceptor {
  Function(DioError) dioerrFunction;
  @override
  Future onRequest(RequestOptions options)async {
    print("option base url is ${options.baseUrl}");
  }

  @override
  Future onError(DioError err)async {
    if(dioerrFunction!=null){
      dioerrFunction(err);
    }

  }

  @override
  Future onResponse(Response response) async{
    AppLogger.print(""
        "Base url is : ${response.request.baseUrl} path is ${response.request.path}\n"
        "Query Parameters is : ${response.request.queryParameters}\n"
        "Headers is : ${response.request.headers}\n"
        "Data is Parameters is : ${response.request.headers}\n"
        "Data is Parameters is : ${response.request.data}\n"


    );
  }
}


class ApiService {

  static Dio dioservice=null;
  static final logInterceptor=LogInterceptors();
  BaseOptions baseOptions;
  ApiService({ this.baseOptions}){

    dioservice = Dio();
    //  dioservice.interceptors.add(logInterceptor); // adding Logging for error and track request and responses
    dioservice.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
    addBaseOptions(); // its called if no base option take global base options

  }

  addBaseOptions(){
    if(baseOptions!=null){
      dioservice.options = baseOptions;
    }else{

      dioservice.options = new BaseOptions(
        baseUrl: webServiceURL,
        connectTimeout: 30000,
        contentType: "application/x-www-form-urlencoded",
        receiveTimeout: 30000,);


    }
    return dioservice;
  }

  Dio getclient() {
    return dioservice;
  }


  void addInterceptor(InterceptorsWrapper wrapper){
    dioservice.interceptors.add(wrapper);
  }

  Future<Response<dynamic>> _errorHandler(DioError dioError) async {
    AppLogger.print(dioError.toString());

    String message;
    if (dioError.type == DioErrorType.RESPONSE) {
      final data = dioError.response.data;
      AppLogger.print(data.toString());

      if (dioError.response.statusCode == 400) {
        message = data['error'];
      } else if (dioError.response.statusCode == 401) {
        message = data['error'];
        if (!message.toLowerCase().contains("otp")){}

      } else if (dioError.response.statusCode == 403) {
        message = "Forbidden";
      } else if (dioError.response.statusCode == 404) {
        message = "Not found";
      } else if (dioError.response.statusCode == 405) {
        message = "Route does not exist";
      } else if (dioError.response.statusCode == 500) {
        message = dioError.message;
      } else {
        message = "Something went wrong";
      }
    } else if (dioError.type == DioErrorType.CONNECT_TIMEOUT) {
      message = "connection timedout";
    } else if (dioError.type == DioErrorType.DEFAULT) {
      if (dioError.message.contains('SocketException')) {
        message = "no internet";
      }
    }

    AppLogger.print(message);


    return dioError.response;
  }

  void addErrorHandler(Function(DioError) mdioerrFunction){
    logInterceptor.dioerrFunction=mdioerrFunction;
  }

}