class Exceptions implements Exception {
  final _message;

  Exceptions([this._message]);

  @override
  String toString() {
    return "$_message";
  }
}

class FetchDataException extends Exceptions {
  FetchDataException([String? message])
      : super('Seems like our shop is offline. Try again later');
}

class BadRequestException extends Exceptions {
  BadRequestException([message]) : super(message);
}

class UnauthorisedException extends Exceptions {
  UnauthorisedException([message]) : super(message);
}

class InvalidInputException extends Exceptions {
  InvalidInputException([String? message]) : super(message);
}
