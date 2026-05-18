import 'package:hive/hive.dart';
import '../models/custom_article_model.dart';

// Service for CRUD operations on custom articles
class CustomArticlesService {
  static const String _boxName = 'custom_articles';
  
  Box<CustomArticleModel> get _box => Hive.box<CustomArticleModel>(_boxName);

  // Initialize the box
  Future<void> init() async {
    await Hive.openBox<CustomArticleModel>(_boxName);
  }

  // CREATE - Add a new custom article
  Future<void> createArticle(CustomArticleModel article) async {
    await _box.put(article.id, article);
  }

  // READ - Get all custom articles
  List<CustomArticleModel> getAllArticles() {
    return _box.values.toList();
  }

  // READ - Get article by ID
  CustomArticleModel? getArticleById(String id) {
    return _box.get(id);
  }

  // READ - Get articles by category
  List<CustomArticleModel> getArticlesByCategory(String category) {
    return _box.values.where((article) => article.category == category).toList();
  }

  // READ - Get important articles
  List<CustomArticleModel> getImportantArticles() {
    return _box.values.where((article) => article.isImportant).toList();
  }

  // READ - Get articles by rating
  List<CustomArticleModel> getArticlesByRating(int minRating) {
    return _box.values.where((article) => article.rating >= minRating).toList();
  }

  // READ - Search articles by title or content
  List<CustomArticleModel> searchArticles(String query) {
    final lowerQuery = query.toLowerCase();
    return _box.values.where((article) {
      return article.title.toLowerCase().contains(lowerQuery) ||
             (article.description?.toLowerCase().contains(lowerQuery) ?? false) ||
             (article.content?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }

  // UPDATE - Update an existing article
  Future<void> updateArticle(CustomArticleModel article) async {
    await _box.put(article.id, article);
  }

  // DELETE - Delete an article by ID
  Future<void> deleteArticle(String id) async {
    await _box.delete(id);
  }

  // DELETE - Delete all articles
  Future<void> deleteAllArticles() async {
    await _box.clear();
  }

  // Get total count
  int getArticleCount() {
    return _box.length;
  }

  // Get statistics
  Map<String, int> getCategoryStats() {
    final stats = <String, int>{};
    for (var article in _box.values) {
      stats[article.category] = (stats[article.category] ?? 0) + 1;
    }
    return stats;
  }
}
