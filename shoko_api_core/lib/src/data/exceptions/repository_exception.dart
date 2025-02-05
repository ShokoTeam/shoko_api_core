import 'package:shoko_api_core/src/domain/utils/error_code.dart';

class RepositoryException implements Exception {
  const RepositoryException(this.errorCode);

  final ErrorCode errorCode;

  @override
  String toString() => 'HttpCode: ${errorCode.httpCode} Code: ${errorCode.internalCode} Message: ${errorCode.message}';
}
