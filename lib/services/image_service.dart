import 'package:Images_App/models/error_response.dart';
import 'package:Images_App/interceptor/interceptor.dart';
import 'package:Images_App/models/image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ImageService extends ChangeNotifier {
  ImageService() {
    getAll();
  }

  List<ImageModel> allImages = [];

  String _search = "";

  bool loading = false;

  String get search => _search;
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  Future<void> getAll() async {
    try {
      final response = await getDio().get('/image');

      if (response.statusCode == 200) {
        final list = response.data as List;

        allImages = list.map((i) {
          return ImageModel.fromJson(i);
        }).toList();
      } else {
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      throw e.message;
    }

    notifyListeners();
  }

  List<ImageModel> get filteredImages {
    final List<ImageModel> filteredImages = [];

    if (search.isEmpty) {
      filteredImages.addAll(allImages);
    } else {
      filteredImages.addAll(allImages.where(
          (p) => p.descripion.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredImages;
  }

  Future<dynamic> consultId(int id) async {
    try {
      final response = await getDio().get('/image/$id');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      final error = ErrorResponse.fromJson(e.response.data);
      throw error.message;
    }
  }

  Future<void> delete(int id) async {
    try {
      final response = await getDio().delete('/image/$id');

      if (response.statusCode == 200) {
        response.data;
      } else {
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      final error = ErrorResponse.fromJson(e.response.data);
      throw error.message;
    }
    getAll();
  }

  Future<void> register(
      {ImageModel model, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final response = await getDio().post('/image/', data: model.toJson());

      if (response.statusCode == 200) {
        onSuccess();
        response.data;
      } else {
        setLoading(false);
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      setLoading(false);
      final error = ErrorResponse.fromJson(e.response.data);
      onFail(error.message);
      throw error.message;
    }
    setLoading(false);
    notifyListeners();
    getAll();
  }

  Future<void> update(ImageModel model) async {
    try {
      final response = await getDio().put('/image/', data: model);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      final error = ErrorResponse.fromJson(e.response.data);
      throw error.message;
    }
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}
