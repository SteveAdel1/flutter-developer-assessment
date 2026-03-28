class NetworkExceptions {
  const NetworkExceptions();

  static String getErrorMessage(NetworkExceptions exception) {
    if (exception is NoInternetConnection) return 'No internet connection';
    if (exception is RequestTimeout) return 'Request timed out';
    if (exception is ServerError) return 'Internal server error';
    if (exception is BadRequest) return exception.message;
    return 'An unexpected error occurred';
  }
}

class NoInternetConnection extends NetworkExceptions {
  const NoInternetConnection();
}

class RequestTimeout extends NetworkExceptions {
  const RequestTimeout();
}

class ServerError extends NetworkExceptions {
  const ServerError();
}

class BadRequest extends NetworkExceptions {
  final String message;
  const BadRequest(this.message);
}
