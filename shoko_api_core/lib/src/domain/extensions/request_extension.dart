import 'dart:convert';

import 'package:bearer_token_package/bearer_token.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:shoko_api_core/src/config.dart';
import 'package:shoko_api_core/src/data/enums/error_code.dart';
import 'package:shoko_api_core/src/data/exceptions/repository_exception.dart';
import 'package:shoko_api_core/src/data/exceptions/wrong_bearer_token_exception.dart';

extension RequestExtension on Request {
  String get userId {
    final token = headers['Authorization']?.replaceAll('Bearer ', '') ?? "";

    final parsedToken = BearerToken.getData(token, Config.instance.secret);

    if (parsedToken.result == null) throw WrongBearerTokenException();

    return parsedToken.result!;
  }

  Future<Map<String, dynamic>> parseBody() async {
    try {
      return jsonDecode(await body());
    } catch (e) {
      throw RepositoryException(ErrorCodes.instance.client.brokenJson);
    }
  }

  bool validateBodyOrQueryParametersKeys(Map<String, dynamic> bodyOrQueryParams, List<String> keys) {
    for (var key in keys) {
      if (!bodyOrQueryParams.containsKey(key)) throw RepositoryException(ErrorCodes.instance.client.wrongJson);
    }
    return true;
  }
}
