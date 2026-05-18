import 'package:hive/hive.dart';

part 'custom_article_model.g.dart';

// Custom article that users can create and edit with enhanced features
@HiveType(typeId: 1)
class CustomArticleModel {
  @HiveField(0)
  final String id; // Unique ID for the article
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String? description;
  
  @HiveField(3)
  final String? content;
  
  @HiveField(4)
  final String? imageUrl;
  
  @HiveField(5)
  final String? author;
  
  @HiveField(6)
  final String category; // Technology, Sports, Business, etc.
  
  @HiveField(7)
  final DateTime createdAt;
  
  @HiveField(8)
  final DateTime? updatedAt;
  
  @HiveField(9)
  final String? notes; // Personal notes about the article
  
  @HiveField(10)
  final int rating; // 1-5 stars
  
  @HiveField(11)
  final List<String> tags; // Custom tags
  
  @HiveField(12)
  final bool isImportant; // Mark as important
  
  // NEW CREATIVE FEATURES
  @HiveField(13)
  final String? summary; // Quick summary of the news
  
  @HiveField(14)
  final String? personalReflection; // How it relates to the user
  
  @HiveField(15)
  final String? mood; // User's mood when reading (Happy, Sad, Angry, Inspired, etc.)
  
  @HiveField(16)
  final int readCount; // How many times user read this
  
  @HiveField(17)
  final DateTime? lastReadAt; // Last time user read this
  
  @HiveField(18)
  final int estimatedReadTime; // Estimated reading time in minutes
  
  @HiveField(19)
  final List<String> highlights; // Important quotes or highlights
  
  @HiveField(20)
  final String? actionItems; // What actions to take based on this news
  
  @HiveField(21)
  final bool isArchived; // Soft delete - archived articles
  
  @HiveField(22)
  final String? sourceUrl; // Original source URL if from external news
  
  @HiveField(23)
  final List<String> relatedTopics; // Related topics for better organization
  
  @HiveField(24)
  final String? keyTakeaway; // Main lesson or takeaway

  CustomArticleModel({
    required this.id,
    required this.title,
    this.description,
    this.content,
    this.imageUrl,
    this.author,
    required this.category,
    required this.createdAt,
    this.updatedAt,
    this.notes,
    this.rating = 0,
    this.tags = const [],
    this.isImportant = false,
    this.summary,
    this.personalReflection,
    this.mood,
    this.readCount = 0,
    this.lastReadAt,
    this.estimatedReadTime = 5,
    this.highlights = const [],
    this.actionItems,
    this.isArchived = false,
    this.sourceUrl,
    this.relatedTopics = const [],
    this.keyTakeaway,
  });

  // Create a copy with updated fields (for UPDATE operation)
  CustomArticleModel copyWith({
    String? title,
    String? description,
    String? content,
    String? imageUrl,
    String? author,
    String? category,
    DateTime? updatedAt,
    String? notes,
    int? rating,
    List<String>? tags,
    bool? isImportant,
    String? summary,
    String? personalReflection,
    String? mood,
    int? readCount,
    DateTime? lastReadAt,
    int? estimatedReadTime,
    List<String>? highlights,
    String? actionItems,
    bool? isArchived,
    String? sourceUrl,
    List<String>? relatedTopics,
    String? keyTakeaway,
  }) {
    return CustomArticleModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      author: author ?? this.author,
      category: category ?? this.category,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      rating: rating ?? this.rating,
      tags: tags ?? this.tags,
      isImportant: isImportant ?? this.isImportant,
      summary: summary ?? this.summary,
      personalReflection: personalReflection ?? this.personalReflection,
      mood: mood ?? this.mood,
      readCount: readCount ?? this.readCount,
      lastReadAt: lastReadAt ?? this.lastReadAt,
      estimatedReadTime: estimatedReadTime ?? this.estimatedReadTime,
      highlights: highlights ?? this.highlights,
      actionItems: actionItems ?? this.actionItems,
      isArchived: isArchived ?? this.isArchived,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      relatedTopics: relatedTopics ?? this.relatedTopics,
      keyTakeaway: keyTakeaway ?? this.keyTakeaway,
    );
  }

  // Increment read count
  CustomArticleModel markAsRead() {
    return copyWith(
      readCount: readCount + 1,
      lastReadAt: DateTime.now(),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'imageUrl': imageUrl,
      'author': author,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'notes': notes,
      'rating': rating,
      'tags': tags,
      'isImportant': isImportant,
      'summary': summary,
      'personalReflection': personalReflection,
      'mood': mood,
      'readCount': readCount,
      'lastReadAt': lastReadAt?.toIso8601String(),
      'estimatedReadTime': estimatedReadTime,
      'highlights': highlights,
      'actionItems': actionItems,
      'isArchived': isArchived,
      'sourceUrl': sourceUrl,
      'relatedTopics': relatedTopics,
      'keyTakeaway': keyTakeaway,
    };
  }
}
