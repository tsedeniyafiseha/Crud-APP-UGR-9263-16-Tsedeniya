import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/article_model.dart';
import '../../../data/repositories/news_repository.dart';

// Events for favorites
abstract class FavoritesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class AddToFavorites extends FavoritesEvent {
  final ArticleModel article;
  AddToFavorites(this.article);
  
  @override
  List<Object?> get props => [article];
}

class RemoveFromFavorites extends FavoritesEvent {
  final String url;
  RemoveFromFavorites(this.url);
  
  @override
  List<Object?> get props => [url];
}

// States for favorites
abstract class FavoritesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<ArticleModel> articles;
  
  FavoritesLoaded(this.articles);
  
  @override
  List<Object?> get props => [articles];
}

// Bloc for managing favorites
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final NewsRepository repository;

  FavoritesBloc(this.repository) : super(FavoritesInitial()) {
    // Load all favorites
    on<LoadFavorites>((event, emit) {
      final articles = repository.getSavedArticles();
      emit(FavoritesLoaded(articles));
    });

    // Add article to favorites
    on<AddToFavorites>((event, emit) async {
      await repository.saveArticle(event.article);
      final articles = repository.getSavedArticles();
      emit(FavoritesLoaded(articles));
    });

    // Remove article from favorites
    on<RemoveFromFavorites>((event, emit) async {
      await repository.removeArticle(event.url);
      final articles = repository.getSavedArticles();
      emit(FavoritesLoaded(articles));
    });
  }
}
