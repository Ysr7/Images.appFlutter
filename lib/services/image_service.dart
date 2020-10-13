import 'package:Images_App/interceptor/error_response.dart';
import 'package:Images_App/interceptor/interceptor.dart';
import 'package:Images_App/models/image.dart';
import 'package:dio/dio.dart';

class ImageService {
  Future<dynamic> getAll() async {
    try {
      var response = await getDio().get('/image');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      var error = ErrorResponse.fromJson(e.response.data);
      throw error.message;
    }
  }

  Future<dynamic> consultId(int id) async {
    try {
      var response = await getDio().get('/image/$id');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      var error = ErrorResponse.fromJson(e.response.data);
      throw error.message;
    }
  }

  Future<dynamic> delete(int id) async {
    try {
      var response = await getDio().delete('/image/$id');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      var error = ErrorResponse.fromJson(e.response.data);
      throw error.message;
    }
  }

  Future<dynamic> register(Image model) async {
    try {
      var response = await getDio().post('/image/', data: model);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      var error = ErrorResponse.fromJson(e.response.data);
      throw error.message;
    }
  }

  Future<dynamic> update(Image model) async {
    try {
      var response = await getDio().put('/image/', data: model);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      var error = ErrorResponse.fromJson(e.response.data);
      throw error.message;
    }
  }
}
