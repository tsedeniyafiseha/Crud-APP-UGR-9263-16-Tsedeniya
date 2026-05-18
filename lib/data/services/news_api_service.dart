import 'package:dio/dio.dart';
import '../models/article_model.dart';

// This service handles all API calls to NewsAPI
class NewsApiService {
  final Dio _dio;
  
  // Your NewsAPI key - get it from https://newsapi.org
  static const String _apiKey = 'd2274c81b1b246d9952220e7430bae4e';
  static const String _baseUrl = 'https://newsapi.org/v2';

  NewsApiService(this._dio) {
    // Setup dio with base configuration
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  // Fetch top headlines (for home screen)
  Future<List<ArticleModel>> getTopHeadlines({String country = 'us'}) async {
    try {
      final response = await _dio.get(
        '/top-headlines',
        queryParameters: {
          'country': country,
          'apiKey': _apiKey,
        },
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        final List articles = response.data['articles'] ?? [];
        return articles.map((json) => ArticleModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } on DioException catch (e) {
      // Handle different types of errors
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout. Please check your internet.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Server is taking too long to respond.');
      } else if (e.response?.statusCode == 401) {
        throw Exception('Invalid API key. Please check your configuration.');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // Search news by keyword
  Future<List<ArticleModel>> searchNews(String query) async {
    try {
      final response = await _dio.get(
        '/everything',
        queryParameters: {
          'q': query,
          'apiKey': _apiKey,
          'sortBy': 'publishedAt',
        },
      );

      if (response.statusCode == 200) {
        final List articles = response.data['articles'] ?? [];
        return articles.map((json) => ArticleModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search news');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout. Please check your internet.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Server is taking too long to respond.');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
