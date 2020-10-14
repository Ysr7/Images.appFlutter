import 'package:dio/dio.dart';

Dio getDio() {
  Dio dio = new Dio();

  dio.options.baseUrl = "http://10.0.2.2:8888";

  dio.interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {}));

  return dio;
}
