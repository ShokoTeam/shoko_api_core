import 'dart:convert';

import 'package:shoko_api_core/shoko_api_core.dart';
import 'package:shoko_api_core/src/backend_responses/backend_error.dart';

extension RequestExtension on Request {
  ///Checking if all required keys are present in the request body
  Future<Map<String, dynamic>> validateBodyByKeys(final List<String> keys) async {
    final code400 = DefaultCodeResponses.c4XX.c400;

    try {
      final parsedBody = jsonDecode(await body());

      bool isValidated = _validateBodyOrQueryParametersKeys(parsedBody, keys);

      if (!isValidated) {
        throw RepositoryException(code400.copyWith(message: 'Not valid request body'));
      }

      return parsedBody;
    } catch (e, st) {
      Logger.instance.e(e, stackTrace: st);

      throw RepositoryException(
          code400.copyWith(message: 'An error occurred while validating the body.'));
    }
  }

  ///Checking if all required keys are present in the request query parameters
  Future<Map<String, dynamic>> validatedQueryParametersByKeys(final List<String> keys) async {
    final code400 = DefaultCodeResponses.c4XX.c400;
    try {
      bool isValidated = _validateBodyOrQueryParametersKeys(uri.queryParameters, keys);

      if (!isValidated) {
        throw RepositoryException(code400.copyWith(message: 'Not valid request query parameters'));
      }
      return uri.queryParameters;
    } catch (e, st) {
      Logger.instance.e(e, stackTrace: st);

      throw RepositoryException(
          code400.copyWith(message: 'An error occurred while validating the query parameters.'));
    }
  }

  ///Method for checking for the presence of keys in the data received in the request
  ///If the key is not found, we immediately return false, since the data is considered invalid.
  bool _validateBodyOrQueryParametersKeys(Map<String, dynamic> requestData, List<String> keys) {
    for (var key in keys) {
      if (!requestData.containsKey(key)) return false;
    }
    return true;
  }
}
