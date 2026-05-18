import '../models/article_model.dart';
import '../services/news_api_service.dart';
import '../services/local_storage_service.dart';

// Repository acts as a bridge between data sources and business logic
// It provides a clean API for the presentation layer
class NewsRepository {
  final NewsApiService _apiService;
  final LocalStorageService _localService;

  NewsRepository(this._apiService, this._localService);

  // Fetch top headlines from API
  Future<List<ArticleModel>> getTopHeadlines() async {
    return await _apiService.getTopHeadlines();
  }

  // Search news from API
  Future<List<ArticleModel>> searchNews(String query) async {
    return await _apiService.searchNews(query);
  }

  // Get saved articles from local storage
  List<ArticleModel> getSavedArticles() {
    return _localService.getSavedArticles();
  }

  // Save article to favorites
  Future<void> saveArticle(ArticleModel article) async {
    await _localService.saveArticle(article);
  }

  // Remove article from favorites
  Future<void> removeArticle(String url) async {
    await _localService.removeArticle(url);
  }

  // Check if article is saved
  bool isArticleSaved(String url) {
    return _localService.isArticleSaved(url);
  }
}
