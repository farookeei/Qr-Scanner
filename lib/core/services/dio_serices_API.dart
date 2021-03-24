import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:qr_user/core/env/app_state.dart';
import '../configs/base_API_configs.dart';

import '../error/http_exception.dart';

class DioAPIServices extends BaseAPIConfig {
  BaseOptions options = new BaseOptions(
    baseUrl: StateHandler.serversType,
    followRedirects: false,
    validateStatus: (status) => true,
  );

  String msgErrorHandle(Map _data) {
    String errorhandleMsg = 'Error Occured';
    if (!_data.containsKey("error")) return null;

    if (_data.containsKey('status')) if (_data['status'] != 'failed')
      return null;

    if (_data.containsKey('status')) if (_data['status'] == 'failed') if (_data
        .containsKey('message')) errorhandleMsg = _data['message'];
    if (_data.containsKey('error')) errorhandleMsg = _data['error']["message"];

    return errorhandleMsg;
  }

  @override
  Future<Map> getAPI({String authorization, String url}) async {
    try {
      Dio _dio = new Dio(options);

      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers['Accept'] = 'application/json';

      if (authorization != null)
        _dio.options.headers['authorization'] = 'Bearer $authorization';

      Response _response =
          await _dio.request(url, options: Options(method: "GET"));

      final _errorMsg = msgErrorHandle(_response.data);

      if (_errorMsg != null)
        throw HttpException(_errorMsg, _response.statusCode);

      if (_response.statusCode < 200 && _response.statusCode > 226)
        throw HttpException('', _response.statusCode);

      return _response.data;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Map> postAPI({
    Map<String, String> addOnHeader,
    Map body,
    String url,
    String authorization,
    bool isMultiPart = false,
  }) async {
    try {
      dynamic _encodeJson = json.encode(body);
      if (body == null) _encodeJson = null;

      Dio _dio = new Dio(options);
      _dio.options.headers['content-Type'] = 'application/json';

      if (authorization != null)
        _dio.options.headers['authorization'] = 'Bearer $authorization';

      Response _response = await _dio
          .request(url, options: Options(method: "POST"), data: _encodeJson)
          .catchError((e) => print(e));

      print(_response.data);
      print("dds");

      final _errorMsg = msgErrorHandle(_response.data);
      print("objectsdref");
      print(_errorMsg);
      if (_errorMsg != null)
        throw HttpException(_errorMsg, _response.statusCode);

      if (_response.statusCode < 200 && _response.statusCode > 226)
        throw HttpException('', _response.statusCode);

      return _response.data;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Map> deleteAPI({
    Map<String, String> addOnHeader,
    Map body,
    String url,
    int id,
    String authorization,
  }) async {
    try {
      Dio _dio = new Dio(options);

      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers['Accept'] = 'application/json';

      if (authorization != null)
        _dio.options.headers['authorization'] = 'Bearer $authorization';

      Response _response =
          await _dio.request(url, options: Options(method: "DELETE"));

      print(_response.data);

      final _errorMsg = msgErrorHandle(_response.data);
      print(_errorMsg);

      if (_errorMsg != null)
        throw HttpException(_errorMsg, _response.statusCode);

      print('pass the message');

      if (_response.statusCode < 200 && _response.statusCode > 226)
        throw HttpException('', _response.statusCode);

      if (_response.data['error'])
        throw HttpException('Error occured', _response.statusCode);

      return _response.data;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Map> patchAPI(
      {Map<String, String> addOnHeader, Map body, String url}) {
    throw UnimplementedError();
  }

  @override
  Future<Map> putAPI(
      {Map<String, String> addOnHeader, Map body, String url, int id}) {
    throw UnimplementedError();
  }

  Future<dynamic> multipleData({
    String url,
    Map<String, dynamic> data,
    String authorization,
  }) async {
    try {
      Dio dio = new Dio();

      FormData formData = FormData.fromMap(data);

      String _url = StateHandler.serversType;

      _url = _url + url;
      if (authorization != null)
        dio.options.headers['authorization'] = 'Bearer $authorization';

      final response =
          await dio.post(_url, data: formData).catchError((e) => print(e));

      return response.data;
    } catch (e) {
      throw e;
    }
  }
}
