// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer' as developer;
import 'package:dart_frog/dart_frog.dart';

enum LogColors {
  error(31),
  warning(33),
  apiCall(36),
  apiResult(32),
  success(32),
  message(37),
  notification(34);

  const LogColors(this.colorCode);
  final int colorCode;
}

final class Logger {
  Logger._();
  static Logger instance = Logger._();

  void _log(final String msg, final LogColors logColor) {
    // final now = DateTime.now();
    final out = msg.split('\n').map((final l) => '\x1B[${logColor.colorCode}m$l\x1B[0m').join('\n');

    developer.log(out);
    print(out);
  }

  void e(final Object? e, {final StackTrace? stackTrace, final int stackTraceLength = 7}) {
    final trace = stackTrace?.toString().split('\n').take(stackTraceLength).join('\n');

    if (e is Exception) {
      _log('[exception] $e\n[stacktrace] ${trace ?? ''}', LogColors.error);
    } else if (e is Error) {
      _log('[error] $e\n[stacktrace] ${trace ?? ''}', LogColors.error);
    } else if (e is String) {
      _log('[error (string)] $e\n[stacktrace] ${trace ?? ''}', LogColors.error);
    } else {
      // If we get here, this means that error was neither an error, nor an exception and I don't
      // really know what happened.
      _log('[error (undefined)] Logger.e() fallback warning - e is undefined', LogColors.warning);
      _log('[${e.runtimeType}] $e\n[stacktrace] ${trace ?? ''}', LogColors.error);
    }
  }

  Future _request(final Request request, final DateTime inTime) async {
    final body = await request.body();

    _log('========================================================================================',
        LogColors.message);
    _log(
      '[request] $inTime [${request.method.name.toUpperCase()}] ${request.uri.path}${request.uri.query == '' ? '' : '?${request.uri.query}'}',
      LogColors.notification,
    );
    if (body.isNotEmpty) _log('[body] $body', LogColors.notification);
  }

  Future<void> _response(final Response response, final Duration elapsed) async {
    _log('[response] ${elapsed.toString()} [${response.statusCode}] ', LogColors.success);
  }

  Handler logRequest(final Handler handler) {
    return (final context) async {
      final now = DateTime.now();
      final stopwatch = Stopwatch();

      await _request(context.request, now);

      stopwatch.start();
      final response = await handler(context);
      stopwatch.stop();

      unawaited(_response(response, stopwatch.elapsed));

      return response;
    };
  }
}
