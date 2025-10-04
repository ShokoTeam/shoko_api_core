import 'package:shoko_api_core/src/backend_responses/response_code.dart';

///Интерфейс, который используется для создания быстрых ответов на запросы
abstract class BackendCodeResponses {
  ResponseCode exceptionByCode() {
    throw UnimplementedError();
  }

  ResponseCode customCode(ResponseCode custom) => custom;
}
