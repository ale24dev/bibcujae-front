import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../resources/urls.dart';
import '../shared/repository/ApiResult.dart';
import 'package:bibcujae/src/models/ejemplar_base_model.dart';

class EjemplarRepository {
  Future<ApiResult<List<dynamic>>> getEjemplaresOfBook(int idBook) async {
    ApiResult<List<dynamic>> result = ApiResult();
    try {
      Map<String, String> headers = {
        'Authorization':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjgwNTY2MjE1LCJpYXQiOjE2ODA1NjU5MTUsImp0aSI6ImQ1Y2VkM2I3ODg4YjRiMWY4YjQ4NWI4MmFhNzc2M2ExIiwidXNlcl9pZCI6Mn0.5t1YtQgoSW4TTmttqhHtiYRJ_4W916CF1q76ZpRFjsU',
      };

      // Map<String, dynamic> params = {
      //   "page": page ?? 1,
      //   "items": items,
      // };

      // Uri targetUrl = Uri.parse(
      //     url ?? Utils.createGetUrl(baseUrl: Urls.getAllBooks, params: params));
      Uri targetUrl = Uri.parse("${Urls.getEjemplaresOfBook}/$idBook");
      var response = await http.get(targetUrl, headers: headers);
      result.statusCode = response.statusCode;
      if (response.statusCode == 200) {
        var decodeResponse = jsonDecode(response.body);

        List<dynamic> bookList = decodeResponse
            .map((currentUnmapped) =>
                EjemplarBaseModel.fromJson(currentUnmapped))
            .toList();

        result.responseObject = bookList;
      }
    } catch (e) {
      print("EROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOR 1" + e.toString());
      result.serverError = e.toString();
    }
    return result;
  }

  Future<ApiResult> createEjemplar(EjemplarBaseModel ejemplarBaseModel) async {
    ApiResult result = ApiResult();
    print(json.encode(ejemplarBaseModel.toJson()));
    try {
      Map<String, String> headers = {
        'Authorization':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjgwNTY2MjE1LCJpYXQiOjE2ODA1NjU5MTUsImp0aSI6ImQ1Y2VkM2I3ODg4YjRiMWY4YjQ4NWI4MmFhNzc2M2ExIiwidXNlcl9pZCI6Mn0.5t1YtQgoSW4TTmttqhHtiYRJ_4W916CF1q76ZpRFjsU',
      };

      Uri targetUrl = Uri.parse(Urls.createEjemplarToBook);
      var response = await http.post(targetUrl,
          headers: headers, body: json.encode(ejemplarBaseModel.toJson()));
      final bytes = response.bodyBytes;
      final imageBytes = bytes;
      result.statusCode = response.statusCode;
      result.responseObject = imageBytes;
    } catch (e) {
      print("EROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOR 1" + e.toString());
      result.serverError = e.toString();
    }
    return result;
  }

  Future<ApiResult> updateEjemplar(
      EjemplarBaseModel ejemplarBaseModel, String ejemplarId) async {
    ApiResult result = ApiResult();

    Map<String, dynamic> map = {
      "cod_barras": ejemplarBaseModel.codBarras,
      "subdivision1": ejemplarBaseModel.subdivision1,
      "subdivision2": ejemplarBaseModel.subdivision2,
      "no_ingreso": ejemplarBaseModel.noIngreso,
      "fecha_ingreso": ejemplarBaseModel.fechaIngreso,
      "ubicacion": ejemplarBaseModel.ubicacion,
      "via_adq": ejemplarBaseModel.viaAdq,
      "procedencia": ejemplarBaseModel.procedencia,
      "precio": ejemplarBaseModel.precio,
      // "estado_ejemplar": ejemplarBaseModel.estadoEjemplar
    };
    print(json.encode(map));
    try {
      Map<String, String> headers = {
        'Authorization':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjgwNTY2MjE1LCJpYXQiOjE2ODA1NjU5MTUsImp0aSI6ImQ1Y2VkM2I3ODg4YjRiMWY4YjQ4NWI4MmFhNzc2M2ExIiwidXNlcl9pZCI6Mn0.5t1YtQgoSW4TTmttqhHtiYRJ_4W916CF1q76ZpRFjsU',
      };

      Uri targetUrl = Uri.parse("${Urls.updateEjemplar}/$ejemplarId");
      var response =
          await http.patch(targetUrl, headers: headers, body: json.encode(map));

      result.statusCode = response.statusCode;
    } catch (e) {
      print("EROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOR 1" + e.toString());
      result.serverError = e.toString();
    }
    return result;
  }

  Future<ApiResult> deleteEjemplar(String ejemplarId) async {
    ApiResult result = ApiResult();
    try {
      Map<String, String> headers = {
        'Authorization':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjgwNTY2MjE1LCJpYXQiOjE2ODA1NjU5MTUsImp0aSI6ImQ1Y2VkM2I3ODg4YjRiMWY4YjQ4NWI4MmFhNzc2M2ExIiwidXNlcl9pZCI6Mn0.5t1YtQgoSW4TTmttqhHtiYRJ_4W916CF1q76ZpRFjsU',
      };

      Uri targetUrl = Uri.parse("${Urls.deleteEjemplar}/$ejemplarId");
      var response = await http.delete(targetUrl, headers: headers);

      result.statusCode = response.statusCode;
    } catch (e) {
      print("EROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOR 1" + e.toString());
      result.serverError = e.toString();
    }
    return result;
  }
}
