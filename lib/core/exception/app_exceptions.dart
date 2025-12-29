class AppExceptions implements Exception {
  String errortitle, errorMsg;

  AppExceptions({required this.errortitle, required this.errorMsg});

  @override
  String toString() {
    return "$errortitle  $errorMsg";
  }
}

class NoInternetException extends AppExceptions {
  NoInternetException({required String msg})
    : super(errortitle: "No Internet!", errorMsg: msg);
}

class ServerException extends AppExceptions {
  ServerException({required String msg})
    : super(errortitle: "Server has an issue please Retry", errorMsg: msg);
}

class BadRequestException extends AppExceptions {
  BadRequestException({required String msg})
      : super(errortitle: "Bad Request", errorMsg: msg);
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException({required String msg})
      : super(errortitle: "Unauthorized", errorMsg: msg);
}
///404
class NotFoundException extends AppExceptions {
  NotFoundException({required String msg})
      : super(errortitle: "Not Found", errorMsg: msg);
}

class InvalidInputException extends AppExceptions {
  InvalidInputException({required String msg})
      : super(errortitle: "Invalid Input", errorMsg: msg);
}
