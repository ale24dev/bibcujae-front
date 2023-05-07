// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html' as html;

import 'package:bibcujae/src/entities/search_filter_entity.dart';

import '../../resources/urls.dart';
import '../entities/book_page_entity.dart';
import '../models/book_base_model.dart';
import '../shared/repository/ApiResult.dart';

import 'package:http/http.dart' as http;

import '../shared/utils.dart';

class BookRepository {
  Future<ApiResult<BookPageEntity>> getAllBooks(
      {int? page, required int items, String? url}) async {
    ApiResult<BookPageEntity> result = ApiResult();
    try {
      Map<String, String> headers = {
        'Authorization':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjgwNTY2MjE1LCJpYXQiOjE2ODA1NjU5MTUsImp0aSI6ImQ1Y2VkM2I3ODg4YjRiMWY4YjQ4NWI4MmFhNzc2M2ExIiwidXNlcl9pZCI6Mn0.5t1YtQgoSW4TTmttqhHtiYRJ_4W916CF1q76ZpRFjsU',
      };

      Map<String, dynamic> params = {
        "page": page ?? 1,
        "items": items,
      };

      Uri targetUrl = Uri.parse(
          url ?? Utils.createGetUrl(baseUrl: Urls.getAllBooks, params: params));
      var response = await http.get(targetUrl, headers: headers);
      result.statusCode = response.statusCode;
      if (response.statusCode == 200) {
        //var decodeResponse = jsonDecode(response.body);
        List<dynamic> jsonList = jsonDecode(response.body)["results"];

        List<BookBaseModel> bookList = jsonList
            .map((currentUnmapped) => BookBaseModel.fromJson(currentUnmapped))
            .toList();
        BookPageEntity bookPageEntity = BookPageEntity(
            count: jsonDecode(response.body)["count"],
            next: jsonDecode(response.body)["next"],
            previous: jsonDecode(response.body)["previous"],
            currentPage: jsonDecode(response.body)["current_page"],
            numPages: jsonDecode(response.body)["num_pages"],
            results: bookList);

        result.responseObject = bookPageEntity;
      }
    } catch (e) {
      print("EROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOR 1" + e.toString());
      result.serverError = e.toString();
    }
    return result;
  }

  Future<void> downloadBooksReport(List<BookBaseModel> listBooks) async {
    Map<String, String> headers = {
      'Authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjgwNTY2MjE1LCJpYXQiOjE2ODA1NjU5MTUsImp0aSI6ImQ1Y2VkM2I3ODg4YjRiMWY4YjQ4NWI4MmFhNzc2M2ExIiwidXNlcl9pZCI6Mn0.5t1YtQgoSW4TTmttqhHtiYRJ_4W916CF1q76ZpRFjsU',
    };
    List<Map<String, dynamic>> listMaps = [];
    for (var book in listBooks) {
      Map<String, dynamic> map = {
        'titulo': book.title,
        'autor': book.author,
        'cod_domicilio': book.domCode,
        'isbn': book.isbn,
        'dewey': book.dewey,
        'publicacion': book.publication,
        'colacion': book.collation,
        'referencia': book.reference,
      };
      listMaps.add(map);
    }
    Uri targetUrl = Uri.parse(Urls.donwloadBookReport);
    var response = await http.post(targetUrl,
        headers: headers, body: jsonEncode(listMaps));

    // Descargar el archivo Excel en el navegador
    var blob = html.Blob([response.bodyBytes],
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    var url = html.Url.createObjectUrlFromBlob(blob);
    html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..download = 'books.xlsx'
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  Future<ApiResult<BookPageEntity>> createBook(
      BookBaseModel bookBaseModel) async {
    ApiResult<BookPageEntity> result = ApiResult();
    try {
      Map<String, String> headers = {
        'Authorization':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjgwNTY2MjE1LCJpYXQiOjE2ODA1NjU5MTUsImp0aSI6ImQ1Y2VkM2I3ODg4YjRiMWY4YjQ4NWI4MmFhNzc2M2ExIiwidXNlcl9pZCI6Mn0.5t1YtQgoSW4TTmttqhHtiYRJ_4W916CF1q76ZpRFjsU',
      };

      Uri targetUrl = Uri.parse(Urls.createBook);
      var response = await http.post(targetUrl,
          headers: headers, body: json.encode(bookBaseModel.toJson()));
      result.statusCode = response.statusCode;
    } catch (e) {
      print("EROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOR 1" + e.toString());
      result.serverError = e.toString();
    }
    return result;
  }

  Future<ApiResult> searchBooksByFilters(
      {int? page,
      required int items,
      String? url,
      required List<SearchFilter> searchFilters}) async {
    ApiResult result = ApiResult();
    try {
      Map<String, String> headers = {
        'Authorization':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjgwNTY2MjE1LCJpYXQiOjE2ODA1NjU5MTUsImp0aSI6ImQ1Y2VkM2I3ODg4YjRiMWY4YjQ4NWI4MmFhNzc2M2ExIiwidXNlcl9pZCI6Mn0.5t1YtQgoSW4TTmttqhHtiYRJ_4W916CF1q76ZpRFjsU',
      };
      Map<String, dynamic> params = {
        "page": page ?? 1,
        "items": items,
      };

      Map<String, dynamic> body = Utils.generateParams(searchFilters);
      Uri targetUrl = Uri.parse(
          "${Urls.searchBooksWithFilters}/?page=${params["page"]}&items=${params["items"]}");
      var response = await http.post(
        targetUrl,
        headers: headers,
        body: json.encode(body),
      );
      result.statusCode = response.statusCode;
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body)["results"];
        List<BookBaseModel> bookList = jsonList
            .map((currentUnmapped) => BookBaseModel.fromJson(currentUnmapped))
            .toList();
        BookPageEntity bookPageEntity = BookPageEntity(
            count: jsonDecode(response.body)["count"],
            next: jsonDecode(response.body)["next"],
            previous: jsonDecode(response.body)["previous"],
            currentPage: jsonDecode(response.body)["current_page"],
            numPages: jsonDecode(response.body)["num_pages"],
            results: bookList);

        result.responseObject = bookPageEntity;
      } else {
        result.serverError = response.body;
      }
    } catch (e) {
      print("ERROOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOR: " + e.toString());
      result.serverError = e.toString();
    }
    return result;
  }
}
