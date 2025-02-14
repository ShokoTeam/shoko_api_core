import 'dart:io';

import 'package:shoko_api_core/shoko_api_core.dart';

Future<void> init(InternetAddress ip, int port) async {
  Config.initialize('pG9BZ4slhFjE1nTmin6C5WSvBbjuCyJk', false);
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  return serve(handler, ip, port);
}
