import 'package:shoko_api_core/src/features/backend_responses/response_code.dart';

///Интерфейс, который используется для создания быстрых ответов на запросы
abstract class BackendCodeResponses {
  ResponseCode exceptionByCode() {
    throw UnimplementedError();
  }

  ResponseCode customCode(ResponseCode custom) => custom;

  final ResponseCode undefiendCode = ResponseCode(httpCode: 500, internalCode: '500', message: 'Something went wrong');
}
