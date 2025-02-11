import 'dart:convert';

import 'package:bearer_token_package/bearer_token.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:shoko_api_core/src/config.dart';
import 'package:shoko_api_core/src/domain/utils/error_code.dart';
import 'package:shoko_api_core/src/data/exceptions/repository_exception.dart';
import 'package:shoko_api_core/src/data/exceptions/wrong_bearer_token_exception.dart';

extension RequestExtension on Request {
  String get userId {
    final token = headers['Authorization']?.replaceAll('Bearer ', '') ?? "";

    final parsedToken = BearerToken.getData(token, Config.instance.secret).result;

    if (parsedToken == null) throw WrongBearerTokenException();

    return parsedToken;
  }

  Future<Map<String, dynamic>> validatedBody(List<String> keys) async {
    try {
      final parsedBody = jsonDecode(await body());

      bool isValidated = _validateBodyOrQueryParametersKeys(parsedBody, keys);

      if (!isValidated) throw RepositoryException(ErrorCodes.instance.client.wrongBodyJson);

      return parsedBody;
    } catch (e) {
      throw RepositoryException(ErrorCodes.instance.client.brokenJson);
    }
  }

  Future<Map<String, dynamic>> validatedQueryParameters(List<String> keys) async {
    try {
      bool isValidated = _validateBodyOrQueryParametersKeys(uri.queryParameters, keys);

      if (!isValidated) throw RepositoryException(ErrorCodes.instance.client.wrongQueryParameters);

      return uri.queryParameters;
    } catch (e) {
      throw RepositoryException(ErrorCodes.instance.client.brokenJson);
    }
  }

  bool _validateBodyOrQueryParametersKeys(Map<String, dynamic> bodyOrQueryParams, List<String> keys) {
    for (var key in keys) {
      if (!bodyOrQueryParams.containsKey(key)) throw RepositoryException(ErrorCodes.instance.client.wrongBodyJson);
    }
    return true;
  }
}
