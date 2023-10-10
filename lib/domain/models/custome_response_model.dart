import 'package:flutter/foundation.dart';

class CustomResponse {
  bool? success;
  String? code;
  String? message;
  dynamic data;
  dynamic fullResponse;
  CustomResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
    this.fullResponse,
  });
}