import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gmapapp/data/api_endpoint.dart';
import 'package:gmapapp/domain/models/custome_response_model.dart';

enum ApiMethod {
  get,
  post,
  delete,
  update,
}

class ApiCallController {


  static BaseOptions? options=BaseOptions(
    baseUrl: ApiEndpoints.baseUrl
  );

  ///instance of dio
  static Dio dio = Dio(options);
  static Response? response;
  static late CustomResponse customResponse;

  ///api method set up
  static Future<CustomResponse> apiMethodSetup({
    required ApiMethod method,
    required String url,
    var data,
    var queryParameters,
  }) async {
    try {
      switch (method) {
        case ApiMethod.get:


          response = await dio.get(url, queryParameters: data);

          break;
        case ApiMethod.post:
          response = await dio.post(
            url,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        case ApiMethod.delete:
          break;
        case ApiMethod.update:
          break;
      }

      final fullResponse = response?.data;

      print("tre");

      customResponse = CustomResponse(
        success: true,
        code: "SUCCESS",
        message: "",
        data: null,
        fullResponse: fullResponse,
      );

      return customResponse;
    } on DioException catch (e) {


      print(e);
      final error;
      if (e.response?.statusCode == 500) {
        error = "Something went wrong";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        error = "Check your network speed";
      } else if (e.type == DioExceptionType.connectionTimeout) {
        error = "Check your connectivity";
      } else {
        error = "Something went wrong";
      }

      customResponse = CustomResponse(
          success: false,
          code: "ERROR",
          message: error,
          data: null,
          fullResponse: null);

      return customResponse;
    }
  }
}
