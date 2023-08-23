class CustomException implements Exception {
  CustomException([this._message, this._prefix]);
  final dynamic _message;
  final dynamic _prefix;

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends CustomException {
  FetchDataException([message]) : super(message, '');
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, 'Unauthorised: ');
}

class InvalidInputException extends CustomException {
  InvalidInputException([message]) : super(message, 'Invalid Input: ');
}
