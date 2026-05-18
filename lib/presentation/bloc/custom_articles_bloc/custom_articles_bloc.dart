import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/custom_article_model.dart';
import '../../../data/services/custom_articles_service.dart';

// Events for custom articles CRUD
abstract class CustomArticlesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCustomArticles extends CustomArticlesEvent {}

class CreateCustomArticle extends CustomArticlesEvent {
  final CustomArticleModel article;
  CreateCustomArticle(this.article);
  
  @override
  List<Object?> get props => [article];
}

class UpdateCustomArticle extends CustomArticlesEvent {
  final CustomArticleModel article;
  UpdateCustomArticle(this.article);
  
  @override
  List<Object?> get props => [article];
}

class DeleteCustomArticle extends CustomArticlesEvent {
  final String id;
  DeleteCustomArticle(this.id);
  
  @override
  List<Object?> get props => [id];
}

class FilterByCategory extends CustomArticlesEvent {
  final String category;
  FilterByCategory(this.category);
  
  @override
  List<Object?> get props => [category];
}

class FilterByImportant extends CustomArticlesEvent {}

class SearchCustomArticles extends CustomArticlesEvent {
  final String query;
  SearchCustomArticles(this.query);
  
  @override
  List<Object?> get props => [query];
}

// States for custom articles
abstract class CustomArticlesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CustomArticlesInitial extends CustomArticlesState {}

class CustomArticlesLoaded extends CustomArticlesState {
  final List<CustomArticleModel> articles;
  final String? filterType;
  
  CustomArticlesLoaded(this.articles, {this.filterType});
  
  @override
  List<Object?> get props => [articles, filterType];
}

class CustomArticleOperationSuccess extends CustomArticlesState {
  final String message;
  CustomArticleOperationSuccess(this.message);
  
  @override
  List<Object?> get props => [message];
}

class CustomArticlesError extends CustomArticlesState {
  final String message;
  CustomArticlesError(this.message);
  
  @override
  List<Object?> get props => [message];
}

// Bloc for managing custom articles
class CustomArticlesBloc extends Bloc<CustomArticlesEvent, CustomArticlesState> {
  final CustomArticlesService service;

  CustomArticlesBloc(this.service) : super(CustomArticlesInitial()) {
    // Load all articles
    on<LoadCustomArticles>((event, emit) {
      try {
        final articles = service.getAllArticles();
        emit(CustomArticlesLoaded(articles));
      } catch (e) {
        emit(CustomArticlesError('Failed to load articles: $e'));
      }
    });

    // Create new article
    on<CreateCustomArticle>((event, emit) async {
      try {
        await service.createArticle(event.article);
        final articles = service.getAllArticles();
        emit(CustomArticleOperationSuccess('Article created successfully!'));
        emit(CustomArticlesLoaded(articles));
      } catch (e) {
        emit(CustomArticlesError('Failed to create article: $e'));
      }
    });

    // Update existing article
    on<UpdateCustomArticle>((event, emit) async {
      try {
        await service.updateArticle(event.article);
        final articles = service.getAllArticles();
        emit(CustomArticleOperationSuccess('Article updated successfully!'));
        emit(CustomArticlesLoaded(articles));
      } catch (e) {
        emit(CustomArticlesError('Failed to update article: $e'));
      }
    });

    // Delete article
    on<DeleteCustomArticle>((event, emit) async {
      try {
        await service.deleteArticle(event.id);
        final articles = service.getAllArticles();
        emit(CustomArticleOperationSuccess('Article deleted successfully!'));
        emit(CustomArticlesLoaded(articles));
      } catch (e) {
        emit(CustomArticlesError('Failed to delete article: $e'));
      }
    });

    // Filter by category
    on<FilterByCategory>((event, emit) {
      try {
        final articles = service.getArticlesByCategory(event.category);
        emit(CustomArticlesLoaded(articles, filterType: 'Category: ${event.category}'));
      } catch (e) {
        emit(CustomArticlesError('Failed to filter articles: $e'));
      }
    });

    // Filter important articles
    on<FilterByImportant>((event, emit) {
      try {
        final articles = service.getImportantArticles();
        emit(CustomArticlesLoaded(articles, filterType: 'Important Articles'));
      } catch (e) {
        emit(CustomArticlesError('Failed to filter articles: $e'));
      }
    });

    // Search articles
    on<SearchCustomArticles>((event, emit) {
      try {
        final articles = service.searchArticles(event.query);
        emit(CustomArticlesLoaded(articles, filterType: 'Search: ${event.query}'));
      } catch (e) {
        emit(CustomArticlesError('Failed to search articles: $e'));
      }
    });
  }
}
