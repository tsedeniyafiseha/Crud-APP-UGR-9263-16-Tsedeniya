import 'package:hive/hive.dart';
import '../models/article_model.dart';

// This service handles local storage for favorite articles
class LocalStorageService {
  static const String _boxName = 'favorites';
  
  // Get the Hive box for favorites
  Box<ArticleModel> get _box => Hive.box<ArticleModel>(_boxName);

  // Initialize Hive box
  Future<void> init() async {
    await Hive.openBox<ArticleModel>(_boxName);
  }

  // Save article to favorites
  Future<void> saveArticle(ArticleModel article) async {
    // Use article URL as unique key
    await _box.put(article.url, article);
  }

  // Remove article from favorites
  Future<void> removeArticle(String url) async {
    await _box.delete(url);
  }

  // Get all saved articles
  List<ArticleModel> getSavedArticles() {
    return _box.values.toList();
  }

  // Check if article is saved
  bool isArticleSaved(String url) {
    return _box.containsKey(url);
  }

  // Clear all favorites
  Future<void> clearAll() async {
    await _box.clear();
  }
}
