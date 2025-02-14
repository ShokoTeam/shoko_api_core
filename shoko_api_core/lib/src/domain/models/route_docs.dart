import 'package:dart_frog/dart_frog.dart';

class RouteDocs {
  const RouteDocs(this.method);
  final HttpMethod method;

  Map<String, dynamic> toJson() => {'method': method.value};
}
