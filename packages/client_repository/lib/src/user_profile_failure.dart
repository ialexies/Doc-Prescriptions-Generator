///Profile Failure
class ClientRepositoryFailure implements Exception {
  ///
  ClientRepositoryFailure({
    required this.message,
  });

  ///initial value
  factory ClientRepositoryFailure.initial() {
    return ClientRepositoryFailure(
      message: '',
    );
  }

  /// error message
  String message;
}
