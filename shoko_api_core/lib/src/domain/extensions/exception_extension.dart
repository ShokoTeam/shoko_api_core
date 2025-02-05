import 'package:dart_frog/dart_frog.dart';
import 'package:shoko_api_core/src/domain/utils/error_code.dart';
import 'package:shoko_api_core/src/domain/utils/logger.dart';

extension ExceptionExtension on Exception {
  Response getRresponse(StackTrace? stack) {
    Logger.instance.e(this, stackTrace: stack, stackTraceLength: 4);

    final errorCode = ErrorCodes.instance.fromException(this);
    return errorCode.response;
  }
}
