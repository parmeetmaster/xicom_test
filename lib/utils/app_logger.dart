import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart' as Log;

class AppLogger {
  static final AppLogger _loggerInstance = AppLogger._makeInstance();

  factory AppLogger() {
    return _loggerInstance;
  }

  AppLogger._makeInstance();

  static final _logger = Log.Logger(
    printer: Log.PrettyPrinter(
      printEmojis: true,
      printTime: false,
      methodCount: 0,
    ),
  );

  static void print(String value) {
    if (!kReleaseMode) {
      _logger.d(value);
    }
  }

  static void e(Exception e, StackTrace s) {
    _logger.e(e, s);
  }
}