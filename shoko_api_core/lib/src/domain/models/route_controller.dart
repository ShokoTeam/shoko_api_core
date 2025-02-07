import 'package:dart_frog/dart_frog.dart';
import 'package:shoko_api_core/src/domain/extensions/exception_extension.dart';
import 'package:shoko_api_core/src/domain/utils/error_code.dart';

abstract class RouteController {
  Future<Response> direct(Request request, [Map<String, dynamic>? dynamicRouteParams]) async {
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
      //if e is not an exception then we don't know the error
      if (e is! Exception) return ErrorCodes.instance.server.undefiend.response;
      return e.getRresponse(st);
    }
  }

  Future<Response> get(Request request, [Map<String, dynamic>? dynamicRouteParams]) async => ErrorCodes.instance.server.notImplemented.response;
  Future<Response> post(Request request, [Map<String, dynamic>? dynamicRouteParams]) async => ErrorCodes.instance.server.notImplemented.response;
  Future<Response> put(Request request, [Map<String, dynamic>? dynamicRouteParams]) async => ErrorCodes.instance.server.notImplemented.response;
  Future<Response> delete(Request request, [Map<String, dynamic>? dynamicRouteParams]) async => ErrorCodes.instance.server.notImplemented.response;
  Future<Response> head(Request request, [Map<String, dynamic>? dynamicRouteParams]) async => ErrorCodes.instance.server.notImplemented.response;
  Future<Response> options(Request request, [Map<String, dynamic>? dynamicRouteParams]) async => ErrorCodes.instance.server.notImplemented.response;
  Future<Response> patch(Request request, [Map<String, dynamic>? dynamicRouteParams]) async => ErrorCodes.instance.server.notImplemented.response;
}
