import 'package:dio/dio.dart';

Dio getDio() {
  Dio dio = new Dio();

  dio.options.baseUrl = "";

  dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {}));

  return dio;
}
