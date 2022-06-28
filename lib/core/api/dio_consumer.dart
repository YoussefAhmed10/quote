import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:qoutes/core/api/api_consumer.dart';
import 'package:qoutes/core/api/app_interceptor.dart';
import 'package:qoutes/core/api/end_points.dart';
import 'package:qoutes/core/api/status_code.dart';
import 'package:qoutes/core/error/exeption.dart';
import 'package:qoutes/injection.dart' as di;

class DioConsumer implements ApiConsumer {
  final Dio clint;

  DioConsumer({required this.clint}) {
    (clint.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    clint.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatuseCode.internalServerError;
      };
    clint.interceptors.add(di.sl<AppInterceptors>());
    if (kDebugMode) {
      clint.interceptors.add(di.sl<LogInterceptor>());
    }
  }

  @override
  Future get(String path, {Map<String, dynamic>? queryPrameter}) async {
    try {
      final response = await clint.get(
        path,
        queryParameters: queryPrameter,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? queryPrameter,
      Map<String, dynamic>? body,
      bool formDataIsEnabled = false}) async {
    try {
      final response = await clint.post(
        path,
        queryParameters: queryPrameter,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future update(String path,
      {Map<String, dynamic>? queryPrameter, Map<String, dynamic>? body}) async {
    try {
      final response = await clint.post(
        path,
        queryParameters: queryPrameter,
        data: body,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = json.decode(response.data.toString());
    return responseJson;
  }

  dynamic _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw const FetchDataException();

      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case StatuseCode.badRequest:
            throw const BadRequestException();
          case StatuseCode.unauthorized:
          case StatuseCode.forbiden:
            throw const UnauthorizedException();
          case StatuseCode.notFount:
            throw const NotFoundException();
          case StatuseCode.conflict:
            throw const ConflictException();
          case StatuseCode.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw const NoInternetConnectionException();
    }
  }
}
