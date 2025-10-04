import 'package:dart_frog/dart_frog.dart';

class ResponseCode {
  const ResponseCode({required this.httpCode, required this.internalCode, required this.message});

  final int httpCode;
  final String internalCode;
  final String message;

  Response get response => Response.json(statusCode: httpCode, body: {'code': internalCode, 'message': message});

  ResponseCode copyWith({int? httpCode, String? internalCode, String? message}) => ResponseCode(
        httpCode: httpCode ?? this.httpCode,
        internalCode: internalCode ?? this.internalCode,
        message: message ?? this.message,
      );
}
