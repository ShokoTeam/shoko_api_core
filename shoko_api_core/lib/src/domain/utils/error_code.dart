import 'package:dart_frog/dart_frog.dart';
import 'package:shoko_api_core/src/data/exceptions/repository_exception.dart';
import 'package:shoko_api_core/src/data/exceptions/wrong_bearer_token_exception.dart';

class ErrorCode {
  const ErrorCode({required this.httpCode, required this.internalCode, required this.message});

  final int httpCode;
  final String internalCode;
  final String message;

  Response get response => Response.json(statusCode: httpCode, body: {'code': internalCode, 'message': message});
}

class ErrorCodes {
  ErrorCodes._();
  static final instance = ErrorCodes._();

  final user = _UserErrorCodes();
  final client = _ClientErrorCodes();
  final server = _ServerErrorCodes();
  final postgres = _PostgresErrorCodes();
  final smtp = _SMTPErrorCodes();

  ErrorCode fromException(Exception exception) {
    return switch (exception) {
      // PostgrestException() => ErrorCodes.postgress,
      WrongBearerTokenException() => user.accessDenied,
      RepositoryException() => exception.errorCode,
      _ => server.undefiend
    };
  }
}

class _UserErrorCodes {
  ///401 - U0 - Unauthorized
  ErrorCode get unauthorized => ErrorCode(httpCode: 401, internalCode: 'U0', message: 'Unauthorized');

  ///403 - U1 - Access denied
  ErrorCode get accessDenied => ErrorCode(httpCode: 403, internalCode: 'U1', message: 'Access denied');

  ///404 - U2 - User not found
  ErrorCode get userNotFound => ErrorCode(httpCode: 404, internalCode: 'U2', message: 'User not found');

  ///403 - U3 - Wrong password
  ErrorCode get wrongPassword => ErrorCode(httpCode: 403, internalCode: 'U3', message: 'Wrong password');
}

class _ClientErrorCodes {
  ///400 - C0 - Received wrong JSON
  ErrorCode get wrongJson => ErrorCode(httpCode: 400, internalCode: 'C0', message: 'Received wrong JSON');

  ///406 - C1 - Received broken JSON
  ErrorCode get brokenJson => ErrorCode(httpCode: 406, internalCode: 'C1', message: 'Received broken JSON');

  ///409 - C2 - This is already exists
  ErrorCode get alreadyExists => ErrorCode(httpCode: 409, internalCode: 'C2', message: 'This object is already exists');

  ///429 - C3 - Much tries
  ErrorCode get muchTries => ErrorCode(httpCode: 429, internalCode: 'C3', message: 'Much tries');

  ///404 - C4 - Not found
  ErrorCode get notFound => ErrorCode(httpCode: 404, internalCode: 'C4', message: 'Not found');
}

class _ServerErrorCodes {
  ///520 - S0 - Something went wrong
  ErrorCode get undefiend => ErrorCode(httpCode: 520, internalCode: 'S0', message: 'Something went wrong');

  ///501 - S1 - Not implemented
  ErrorCode get notImplemented => ErrorCode(httpCode: 501, internalCode: 'S1', message: 'Not implemented');

  ///503 - S2 - The service is temporarily unavailable
  ErrorCode get unvailable => ErrorCode(httpCode: 503, internalCode: 'S2', message: 'The service is temporarily unavailable');
}

class _PostgresErrorCodes {
  ///500 - SP0 - Database error
  ErrorCode get postgress => ErrorCode(httpCode: 500, internalCode: 'SP0', message: 'Database error');

  ///404 - SP1 - Database error
  ErrorCode get notFoundInDb => ErrorCode(httpCode: 404, internalCode: 'SP1', message: 'The object wasn\'t found in the db');
}

class _SMTPErrorCodes {
  ErrorCode get smtpError => ErrorCode(httpCode: 500, internalCode: 'SSMTP0', message: 'Couldn\'t send email');
}
