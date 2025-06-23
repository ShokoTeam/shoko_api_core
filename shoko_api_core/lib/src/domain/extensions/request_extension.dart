import 'dart:convert';

import 'package:bearer_token_package/bearer_token.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:shoko_api_core/src/config.dart';
import 'package:shoko_api_core/src/data/exceptions/repository_exception.dart';
import 'package:shoko_api_core/src/features/backend_responses/backend_error.dart';

extension RequestExtension on Request {
  String get userId {
    final token = headers['Authorization']?.replaceAll('Bearer ', '') ?? "";

    final parsedToken = BearerToken.getData(token, Config.instance.secret).result;

    if (parsedToken == null) throw DefaultCodeResponses.instance.c4XX.c403;

    return parsedToken;
  }

  Future<Map<String, dynamic>> validatedBody(List<String> keys) async {
    final code400 = DefaultCodeResponses.instance.c4XX.c400;
    try {
      final parsedBody = jsonDecode(await body());

      bool isValidated = _validateBodyOrQueryParametersKeys(parsedBody, keys);

      if (!isValidated) {
        throw RepositoryException(code400.copyWith(message: 'Wrong body json'));
      }

      return parsedBody;
    } catch (e) {
      throw RepositoryException(code400.copyWith(message: 'Broken json'));
    }
  }

  Future<Map<String, dynamic>> validatedQueryParameters(List<String> keys) async {
    final code400 = DefaultCodeResponses.instance.c4XX.c400;
    try {
      bool isValidated = _validateBodyOrQueryParametersKeys(uri.queryParameters, keys);

      if (!isValidated) {
        throw RepositoryException(code400.copyWith(message: 'Wrong query parameters'));
      }
      return uri.queryParameters;
    } catch (e) {
      throw RepositoryException(code400.copyWith(message: 'Broken json'));
    }
  }

  bool _validateBodyOrQueryParametersKeys(Map<String, dynamic> bodyOrQueryParams, List<String> keys) {
    for (var key in keys) {
      if (!bodyOrQueryParams.containsKey(key)) return false;
    }
    return true;
  }
}
