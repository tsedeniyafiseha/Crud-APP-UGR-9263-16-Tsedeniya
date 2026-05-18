import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/article_model.dart';
import '../../../data/repositories/news_repository.dart';

// Events - what can happen
abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTopHeadlines extends NewsEvent {}

class SearchNews extends NewsEvent {
  final String query;
  SearchNews(this.query);
  
  @override
  List<Object?> get props => [query];
}

class RefreshNews extends NewsEvent {}

// States - what the UI can be in
abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<ArticleModel> articles;
  
  NewsLoaded(this.articles);
  
  @override
  List<Object?> get props => [articles];
}

class NewsError extends NewsState {
  final String message;
  
  NewsError(this.message);
  
  @override
  List<Object?> get props => [message];
}

// Bloc - handles events and emits states
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  NewsBloc(this.repository) : super(NewsInitial()) {
    // Handle LoadTopHeadlines event
    on<LoadTopHeadlines>((event, emit) async {
      emit(NewsLoading());
      try {
        final articles = await repository.getTopHeadlines();
        emit(NewsLoaded(articles));
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });

    // Handle SearchNews event
    on<SearchNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final articles = await repository.searchNews(event.query);
        if (articles.isEmpty) {
          emit(NewsError('No articles found for "${event.query}"'));
        } else {
          emit(NewsLoaded(articles));
        }
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });

    // Handle RefreshNews event
    on<RefreshNews>((event, emit) async {
      try {
        final articles = await repository.getTopHeadlines();
        emit(NewsLoaded(articles));
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });
  }
}
