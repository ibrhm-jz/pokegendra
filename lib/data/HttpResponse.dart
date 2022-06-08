// ignore_for_file: file_names
class HttpResponse<T> {
  final T? data;
  final HttpError? error;
  final int? statusCode;
  final bool haveInternetConnection;

  HttpResponse(
    this.data,
    this.error, {
    this.statusCode = -1,
    this.haveInternetConnection = true,
  });

  static HttpResponse<T> success<T>(
    T data,
    int statusCode, {
    bool haveInternetConnection = true,
  }) =>
      HttpResponse(
        data,
        null,
        statusCode: statusCode,
        haveInternetConnection: haveInternetConnection,
      );

  static HttpResponse<T> fail<T>({
    required int statusCode,
    required String message,
    required dynamic data,
    bool haveInternetConnection = true,
  }) =>
      HttpResponse(
        null,
        HttpError(
          statusCode: statusCode,
          message: message,
          data: data,
        ),
        haveInternetConnection: haveInternetConnection,
      );
}

class HttpError {
  final int statusCode;
  final String message;
  final dynamic data;

  HttpError({
    required this.statusCode,
    required this.message,
    required this.data,
  });
}
