import 'package:dart_frog/dart_frog.dart';
import 'package:shoko_api_core/src/exceptions/repository_exception.dart';
import 'package:shoko_api_core/src/domain/utils/logger.dart';
import 'package:shoko_api_core/src/backend_responses/backend_error.dart';

abstract class RouteController {
  Future<Response> direct(Request request, {Map<String, dynamic>? dynamicRouteParams}) async {
    try {
      final response = await switch (request.method) {
        HttpMethod.get => get(request, dynamicRouteParams),
        HttpMethod.post => post(request, dynamicRouteParams),
        HttpMethod.put => put(request, dynamicRouteParams),
        HttpMethod.delete => delete(request, dynamicRouteParams),
        HttpMethod.head => head(request, dynamicRouteParams),
        HttpMethod.options => options(request, dynamicRouteParams),
        HttpMethod.patch => patch(request, dynamicRouteParams)
      };

      return response;
    } catch (e, st) {
      if (e is RepositoryException) return e.code.response;

      Logger.instance.e(this, stackTrace: st, stackTraceLength: 4);

      return DefaultCodeResponses.c5XX.c500.response;
    }
  }

  Future<Response> get(Request request, [Map<String, dynamic>? dynamicRouteParams]) async =>
      DefaultCodeResponses.c5XX.c501.response;
  Future<Response> post(Request request, [Map<String, dynamic>? dynamicRouteParams]) async =>
      DefaultCodeResponses.c5XX.c501.response;
  Future<Response> put(Request request, [Map<String, dynamic>? dynamicRouteParams]) async =>
      DefaultCodeResponses.c5XX.c501.response;
  Future<Response> delete(Request request, [Map<String, dynamic>? dynamicRouteParams]) async =>
      DefaultCodeResponses.c5XX.c501.response;
  Future<Response> head(Request request, [Map<String, dynamic>? dynamicRouteParams]) async =>
      DefaultCodeResponses.c5XX.c501.response;
  Future<Response> options(Request request, [Map<String, dynamic>? dynamicRouteParams]) async =>
      DefaultCodeResponses.c5XX.c501.response;
  Future<Response> patch(Request request, [Map<String, dynamic>? dynamicRouteParams]) async =>
      DefaultCodeResponses.c5XX.c501.response;
}
