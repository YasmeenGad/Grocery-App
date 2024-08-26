abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class TimeoutFailure extends NetworkFailure {
  const TimeoutFailure() : super('Connection timed out. Please try again.');
}

class NoInternetFailure extends NetworkFailure {
  const NoInternetFailure()
      : super('No internet connection. Please check your network settings.');
}

// Server-side failures with specific status codes
class ServerFailure extends Failure {
  final int statusCode;
  const ServerFailure(String message, this.statusCode) : super(message);
}

class UnauthorizedFailure extends ServerFailure {
  const UnauthorizedFailure()
      : super('You are not authorized. Please log in.', 401);
}

class NotFoundFailure extends ServerFailure {
  const NotFoundFailure() : super('The requested resource was not found.', 404);
}

class InternalServerErrorFailure extends ServerFailure {
  const InternalServerErrorFailure()
      : super('Internal server error. Please try again later.', 500);
}

// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure({String message = 'No data found in cache'})
      : super(message);
}
