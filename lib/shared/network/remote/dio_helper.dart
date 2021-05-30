import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> qul,
    String long = 'en',
    String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': long,
      'Authorization': token ??
          'b676yF4HQTAGtP9bYNM2kjAw3VZ6vd63Ar7dr7jQvhISokVKIK5K3Emr4tiPctOBgBlZhV',
    };
    return await dio.get(
      url,
      queryParameters: qul,
    );
  }

  static Future<Response> postData({
    @required String url,
    Map<String, dynamic> qul,
    @required Map<String, dynamic> data,
    String long = 'en',
    String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': long,
      'Authorization': token ??
          'b676yF4HQTAGtP9bYNM2kjAw3VZ6vd63Ar7dr7jQvhISokVKIK5K3Emr4tiPctOBgBlZhV',
    };
    return dio.post(
      url,
      queryParameters: qul,
      data: data,
    );
  }

  static Future<Response> putData({
    @required String url,
    @required Map<String, dynamic> data,
    Map<String, dynamic> query,
    String lang = 'en',
    String token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };

    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
