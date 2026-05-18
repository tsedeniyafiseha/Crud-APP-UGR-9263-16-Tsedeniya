import 'package:hive/hive.dart';

part 'article_model.g.dart';

// This is our data model that represents a news article
// It matches the structure from NewsAPI response
@HiveType(typeId: 0)
class ArticleModel {
  @HiveField(0)
  final String? author;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String? description;
  
  @HiveField(3)
  final String url;
  
  @HiveField(4)
  final String? urlToImage;
  
  @HiveField(5)
  final String publishedAt;
  
  @HiveField(6)
  final String? content;
  
  @HiveField(7)
  final String? sourceName;

  ArticleModel({
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
    this.sourceName,
  });

  // Convert JSON from API to ArticleModel
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      author: json['author'],
      title: json['title'] ?? 'No Title',
      description: json['description'],
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'],
      sourceName: json['source']?['name'],
    );
  }

  // Convert ArticleModel to JSON (useful for debugging)
  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'sourceName': sourceName,
    };
  }
}
