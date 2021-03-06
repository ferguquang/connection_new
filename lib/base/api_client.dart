import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'app_url.dart';

class APIClient {
  static APIClient? _instance;
  Dio? _dio;

  static const int timeout_code = 900;

  static const int dio_error_default = 901;
  static const int dio_error_response = 902;
  static const int dio_error_no_reason = 903;

  static APIClient? get instance {
    if (_instance == null) {
      _instance = APIClient();
    }
    return _instance;
  }

  APIClient() {
    _dio = Dio();
    _dio!.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) async {

          options.headers["content-type"] = "application/json";

          options.connectTimeout = 30000; //5s
          options.receiveTimeout = 30000;

          options.baseUrl = AppUrl.baseURL;

          handler.next(options);
        },
        onResponse: (response, ResponseInterceptorHandler handler) {
          handler.next(response);
        }
    ));

    _dio!.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<dynamic> postData(String path, {bool isLoading = true, dynamic params}) async {

    var responseJson;
    try {
      Response response = await _dio!.post(path, data: params);
      responseJson = _response(response);
    } on DioError catch (ex) {
      // if (isLoading) {
      //   hideLoading();
      // }
      return _errorException(dioError: ex);
    } on Exception {
      // if (isLoading) {
      //   hideLoading();
      // }
      return _errorException();
    } finally {
      if (isLoading) {
      }
    }

    return responseJson;
  }

  Future<dynamic> get(String path,
      {Map<String, dynamic>? params, bool isLoading = true}) async {
    if (params == null) {
      params = {};
    }

    var responseJson;
    try {
      Response response = await _dio!.get(path, queryParameters: params);
      responseJson = _response(response);
    } on DioError catch (ex) {
      // if (isLoading) {
      //   hideLoading();
      // }
      return _errorException(dioError: ex);
    } on Exception {
      // if (isLoading) {
      //   hideLoading();
      // }
      return _errorException();
    } finally {

    }
    return responseJson;
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
      //get body of response
        var responseJson = json.decode(response.toString());
        return responseJson;
      // case 400:
      //   return _getErrorResponse(
      //       message: "C?? ph??p kh??ng h???p l???", code: response.statusCode);
      // case 401:
      // case 403:
      //   return _getErrorResponse(
      //       message: "C?? v???n ????? khi x??c th???c trong t??i kho???n c???a b???n",
      //       code: response.statusCode);
      // case 404:
      //   return _getErrorResponse(
      //       message: "Kh??ng th??? truy c???p ?????n m??y ch???",
      //       code: response.statusCode);
      // case 500:
      //   return _getErrorResponse(
      //       message: "M??y ch??? g???p l???i", code: response.statusCode);
      // default:
      //   return _getErrorResponse(
      //       message: "K???t n???i ?????n m??y ch??? th???t b???i", code: response.statusCode);
    }
  }

  Future<Map<String, dynamic>> _errorException(
      {String message: "K???t n???i ?????n m??y ch??? th???t b???i.",
        DioError? dioError,
        int code: 0}) async {
    String resultCode = "";
    if (dioError != null) {
      switch (dioError.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          {
            message = "M??y ch??? kh??ng ph???n h???i";
            code = timeout_code;
            break;
          }
        case DioErrorType.other:
          {
            // if (dioError.error is SocketException &&
            //     isNotNullOrEmpty(dioError?.error?.osError?.errorCode))
            //   resultCode = " (${dioError?.error?.osError?.errorCode})";
            // message = "Kh??ng t??m th???y m??y ch??? $resultCode";
            // code = dio_error_default;
            return _getErrorResponse(message: message, code: code, isNotAddCode: true);
          }
        case DioErrorType.cancel:
          // TODO: Handle this case.
          break;
      }
    }
    return _getErrorResponse(message: message, code: code);
  }

  Map<String, dynamic> _getErrorResponse(
      {String? message, int? code, bool isNotAddCode: false}) {
    String stringCode = " ($code).";
    if (code == timeout_code) {
      stringCode = " (timeout)";
    }
//     return jsonDecode("""{
//   "Status": ${code ?? 0},
//   "Data": null,
//   "Messages": "$message${isNotAddCode ? "" : stringCode}"
// }""");
    return jsonDecode("""{
      "success": false,
      "status": null,
      "message": "$message${isNotAddCode ? "" : stringCode}",
      "error": null,
      "data": null
    }""");
  }
}