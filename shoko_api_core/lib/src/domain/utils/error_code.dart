// import 'package:dart_frog/dart_frog.dart';
// import 'package:shoko_api_core/src/data/exceptions/repository_exception.dart';
// import 'package:shoko_api_core/src/data/exceptions/wrong_bearer_token_exception.dart';

// class ErrorCode {
//   const ErrorCode({required this.httpCode, required this.internalCode, required this.message});

//   final int httpCode;
//   final String internalCode;
//   final String message;

//   Response get response => Response.json(statusCode: httpCode, body: {'code': internalCode, 'message': message});
// }

// class ErrorCodes {
//   ErrorCodes._();
//   static final instance = ErrorCodes._();

//   final user = const _UserErrorCodes();
//   final client = const _ClientErrorCodes();
//   final server = const _ServerErrorCodes();
//   final postgres = const _PostgresErrorCodes();
//   final smtp = const _SMTPErrorCodes();

//   ErrorCode fromException(Exception exception) {
//     return switch (exception) {
//       WrongBearerTokenException() => user.accessDenied,
//       RepositoryException() => exception.errorCode,
//       _ => server.undefiend,
//     };
//   }
// }

// class _UserErrorCodes {
//   const _UserErrorCodes();

//   ///401 - U0 - Unauthorized
//   final unauthorized = const ErrorCode(httpCode: 401, internalCode: 'U0', message: 'Unauthorized');

//   ///403 - U1 - Access denied
//   final accessDenied = const ErrorCode(httpCode: 403, internalCode: 'U1', message: 'Access denied');

//   ///404 - U2 - User not found
//   final userNotFound = const ErrorCode(httpCode: 404, internalCode: 'U2', message: 'User not found');

//   ///403 - U3 - Wrong password
//   final wrongPassword = const ErrorCode(httpCode: 403, internalCode: 'U3', message: 'Wrong password');
// }

// class _ClientErrorCodes {
//   const _ClientErrorCodes();

//   ///400 - C0 - Received wrong JSON
//   final wrongBodyJson = const ErrorCode(httpCode: 400, internalCode: 'C0', message: 'Received wrong BodyJson');

//   ///400 - C1 - Received wrong QueryParameters
//   final wrongQueryParameters = const ErrorCode(httpCode: 400, internalCode: 'C1', message: 'Received wrong QueryParameters');

//   ///406 - C2 - Received broken JSON
//   final brokenJson = const ErrorCode(httpCode: 406, internalCode: 'C2', message: 'Received broken JSON');

//   ///409 - C3 - This is already exists
//   final alreadyExists = const ErrorCode(httpCode: 409, internalCode: 'C3', message: 'This object is already exists');

//   ///429 - C4 - Much tries
//   final muchTries = const ErrorCode(httpCode: 429, internalCode: 'C4', message: 'Much tries');

//   ///404 - C5 - Not found
//   final notFound = const ErrorCode(httpCode: 404, internalCode: 'C5', message: 'Not found');
// }

// class _ServerErrorCodes {
//   const _ServerErrorCodes();

//   ///520 - S0 - Something went wrong
//   final undefiend = const ErrorCode(httpCode: 520, internalCode: 'S0', message: 'Something went wrong');

//   ///501 - S1 - Not implemented
//   final notImplemented = const ErrorCode(httpCode: 501, internalCode: 'S1', message: 'Not implemented');

//   ///503 - S2 - The service is temporarily unavailable
//   final unvailable = const ErrorCode(httpCode: 503, internalCode: 'S2', message: 'The service is temporarily unavailable');
// }

// class _PostgresErrorCodes {
//   const _PostgresErrorCodes();

//   ///500 - SP0 - Database error
//   final postgress = const ErrorCode(httpCode: 500, internalCode: 'SP0', message: 'Database error');

//   ///404 - SP1 - Database error
//   final notFoundInDb = const ErrorCode(httpCode: 404, internalCode: 'SP1', message: 'The object wasn\'t found in the db');
// }

// class _SMTPErrorCodes {
//   const _SMTPErrorCodes();
//   final smtpError = const ErrorCode(httpCode: 500, internalCode: 'SSMTP0', message: 'Couldn\'t send email');
// }
