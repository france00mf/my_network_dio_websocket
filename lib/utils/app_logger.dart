import 'dart:developer';


class LoggerColor {
  static const black = "\x1B[30m";
  static const red = "\x1B[31m";
  static const green = "\x1B[32m";
  static const yellow = "\x1B[33m";
  static const blue = "\x1B[34m";
  static const magenta = "\x1B[35m";
  static const cyan = "\x1B[36m";
  static const white = "\x1B[37m";
  static const lightGrey = " \x1B[37;1m";
  static const darkGrey = "\x1B[90m";
}


AppLogger appLogger(Type type) => AppLogger(type);

class AppLogger {
  final Type type;

  const AppLogger(this.type);

  
  void v(dynamic message,
      {dynamic error, StackTrace? stackTrace, String? functionName}) {
    log(
      LoggerColor.magenta + message.toString() + LoggerColor.magenta,
      error: error,
      stackTrace: stackTrace,
      name:
          "\x1B[37m${type.toString()}${functionName == null ? "" : '.$functionName'}\x1B[37m",
    );
  }

  
  void d(dynamic message,
      {dynamic error, StackTrace? stackTrace, String? functionName}) {
    log(
      "\x1B[32m${message.toString()}\x1B[32m",
      error: error,
      stackTrace: stackTrace,
      name:
          "\x1B[37m${type.toString()}${functionName == null ? "" : '.$functionName'}\x1B[37m",
    );
  }

  
  void i(dynamic message,
      {dynamic error, StackTrace? stackTrace, String? functionName}) {
    log(
      "\x1B[36m${message.toString()}\x1B[36m",
      error: error,
      stackTrace: stackTrace,
      name:
          "\x1B[37m${type.toString()}${functionName == null ? "" : '.$functionName'}\x1B[37m",
    );
  }

  
  void w(dynamic message,
      {dynamic error, StackTrace? stackTrace, String? functionName}) {
    log(
      message.toString(),
      error: error,
      stackTrace: stackTrace,
      name:
          "\x1B[37m${type.toString()}${functionName == null ? "" : '.$functionName'}\x1B[37m",
    );
  }

  
  void e(dynamic message,
      {dynamic error, StackTrace? stackTrace, String? functionName}) {
    log(
      "\x1B[31m${message.toString()}\x1B[31m",
      error: error,
      stackTrace: stackTrace,
      name:
          "\x1B[37m${type.toString()}${functionName == null ? "" : '.$functionName'}\x1B[37m",
    );
  }

  
  void custom(
    dynamic message, {
    String color = "",
    dynamic error,
    StackTrace? stackTrace,
    String? functionName,
  }) {
    log(
      color + message.toString() + color,
      error: error,
      stackTrace: stackTrace,
      name:
          "\x1B[37m${type.toString()}${functionName == null ? "" : '.$functionName'}\x1B[37m",
    );
  }
}
