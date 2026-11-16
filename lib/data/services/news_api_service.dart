
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:news_app/core/constants/api_constants.dart';
import 'package:news_app/data/services/news_api_exception.dart';

import '../models/article.dart';

class NewsApiService {
  final http.Client _client;

  NewsApiService({http.Client? client})
      : _client = client ?? http.Client();

  // Mengambil berita utama Indonesia
  Future<List<Article>> fetchTopHeadlines(String category) async {
    return _get('/top-headlines', {
      'country': 'id',
      'category': category,
    });
  }

  // Mencari artikel
  Future<List<Article>> searchArticles(String query) async {
    return _get('/everything', {
      'q': query,
      'sortBy': 'publishedAt',
    });
  }

  Future<List<Article>> _get(
    String path,
    Map<String, String> params,
  ) async {
    final apiKey = ApiConstants.apiKey;

    if (apiKey.isEmpty) {
      debugPrint('[NewsAPI] NEWS_API_KEY kosong!');
      throw NewsApiException.serviceUnavailable;
    }

    final uri = Uri.parse('${ApiConstants.baseUrl}$path').replace(
      queryParameters: {
        ...params,
        'pageSize': '${ApiConstants.pageSize}',
        'apiKey': apiKey,
      },
    );

    try {
        final response = await _client
        .get(uri)
        .timeout(ApiConstants.timeout);
        debugPrint('[NewsAPI] STATUS: ${response.statusCode}');
        debugPrint('[NewsAPI] BODY: ${response.body}');
        debugPrint('[NewsAPI] PATH: $path');

      if (response.statusCode != 200) {
        debugPrint(
          '[NewsAPI] HTTP ${response.statusCode}: ${response.body}',
        );
        throw _formStatusCode(response.statusCode);
      }

      final body =
          jsonDecode(response.body) as Map<String, dynamic>;

      final articles = body['articles'] as List<dynamic>? ?? [];

      return articles
          .map(
            (json) => Article.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .where((article) => article.isValid)
          .toList();
    } on NewsApiException {
      rethrow;
    } on SocketException {
      throw NewsApiException.offline;
    } on http.ClientException {
      throw NewsApiException.offline;
    } on TimeoutException {
      throw NewsApiException.slowConnection;
    } catch (error) {
      debugPrint('[NewsAPI] Unexpected error: $error');
      throw NewsApiException.unknown;
    }
  }

  NewsApiException _formStatusCode(int code) => switch (code) {
        401 || 403 => NewsApiException.serviceUnavailable,
        429 => NewsApiException.tooManyRequests,
        >= 500 => NewsApiException.serverBusy,
        _ => NewsApiException.unknown,
      };
}
