import 'package:shoko_api_core/src/features/backend_responses/response_code.dart';

class RepositoryException implements Exception {
  const RepositoryException(this.code);

  final ResponseCode code;

  @override
  String toString() => 'HttpCode: ${code.httpCode} Code: ${code.internalCode} Message: ${code.message}';
}
