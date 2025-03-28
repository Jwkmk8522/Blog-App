class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class MyAuthException implements Exception {
  final String message;
  const MyAuthException(this.message);
}
