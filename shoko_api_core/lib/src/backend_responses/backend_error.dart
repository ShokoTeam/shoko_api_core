import 'package:shoko_api_core/src/backend_responses/backend_responses.dart';
import 'package:shoko_api_core/src/backend_responses/response_code.dart';

class _HTTPCodes200 {
  const _HTTPCodes200();
  final c200 = const ResponseCode(httpCode: 200, internalCode: '200', message: 'Success');
  final c201 = const ResponseCode(httpCode: 201, internalCode: '201', message: 'Created');
  final c202 = const ResponseCode(httpCode: 202, internalCode: '202', message: 'Accepted');
  final c203 = const ResponseCode(
    httpCode: 203,
    internalCode: '201',
    message: 'Non-authoritative information',
  );
  final c204 = const ResponseCode(httpCode: 204, internalCode: '201', message: 'No content');
}

class _HTTPCodes400 {
  const _HTTPCodes400();

  ///Bad request
  final c400 = const ResponseCode(httpCode: 400, internalCode: '201', message: 'Bad request');

  ///Unauthorized
  final c401 = const ResponseCode(httpCode: 401, internalCode: '201', message: 'Unauthorized');

  ///Forbidden
  final c403 = const ResponseCode(httpCode: 403, internalCode: '201', message: 'Forbidden');

  ///Not found
  final c404 = const ResponseCode(httpCode: 404, internalCode: '201', message: 'Not found');

  ///Not allowed
  final c405 = const ResponseCode(httpCode: 405, internalCode: '201', message: 'Not allowed');
}

class _HTTPCodes500 {
  const _HTTPCodes500();

  ///Internal server error
  final c500 = const ResponseCode(
    httpCode: 500,
    internalCode: '201',
    message: 'Internal server error',
  );

  ///Not implemented
  final c501 = const ResponseCode(httpCode: 501, internalCode: '201', message: 'Not implemented');

  ///Bad gateway
  final c502 = const ResponseCode(httpCode: 502, internalCode: '201', message: 'Bad gateway');

  ///Service unvailable
  final c503 = const ResponseCode(
    httpCode: 503,
    internalCode: '201',
    message: 'Service unvailable',
  );
}

class DefaultCodeResponses extends BackendCodeResponses {
  DefaultCodeResponses._();
  static const c2XX = _HTTPCodes200();
  static const c4XX = _HTTPCodes400();
  static const c5XX = _HTTPCodes500();
}
