import 'dart:convert';

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

  String get search => _search;
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  Future<void> getAll() async {
    try {
      var response = await getDio().get('/image');

      if (response.statusCode == 200) {
        var list = response.data as List;

        allImages = list.map((i) {
          return ImageModel.fromJson(i);
        }).toList();
      } else {
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      var error = ErrorResponse.fromJson(e.response.data);
      throw error.message;
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

  Future<dynamic> register(ImageModel model) async {
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

  Future<dynamic> update(ImageModel model) async {
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
