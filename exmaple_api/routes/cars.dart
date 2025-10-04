import 'package:shoko_api_core/shoko_api_core.dart';

Future<Response> onRequest(RequestContext context) async =>
    _RouteController().direct(context.request);

class _RouteController extends RouteController {
  @override
  Future<Response> get(Request request, [Map<String, dynamic>? dynamicRouteParams]) {
    return super.get(request, dynamicRouteParams);
  }
}
