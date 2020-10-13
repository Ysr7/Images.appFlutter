import 'package:dio/dio.dart';

Dio getDio() {
  Dio dio = new Dio();

  dio.options.baseUrl = "http://0.0.0.0:8888";

  dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {}));

  return dio;
}
