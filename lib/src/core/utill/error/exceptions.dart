/// this is custom class for server exception
class ServerException implements Exception {
  final String? message;
  final String? errorCode;
  final String? statusCode;
  final String? errorDescription;

  ServerException({
    this.message,
    this.errorCode,
    this.statusCode,
    this.errorDescription,
  });
}

/// this is custom class for cache exception
class CacheException implements Exception {
  final String? message;
  final String? errorCode;
  final String? statusCode;
  final String? errorDescription;

  CacheException({
    this.message,
    this.errorCode,
    this.statusCode,
    this.errorDescription,
  });
}
