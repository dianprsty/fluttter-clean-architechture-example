import 'package:bloc/bloc.dart';
import 'package:clean_architecture_example/features/daily_news/domain/entities/article.dart';
import 'package:clean_architecture_example/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:clean_architecture_example/features/daily_news/domain/usecases/remove_article.dart';
import 'package:clean_architecture_example/features/daily_news/domain/usecases/save_article.dart';
import 'package:equatable/equatable.dart';

part 'local_article_event.dart';
part 'local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;
  LocalArticleBloc(
    this._getSavedArticleUseCase,
    this._saveArticleUseCase,
    this._removeArticleUseCase,
  ) : super(const LocalArticleLoading()) {
    on<GetSavedArticles>(onGetSavedArticle);
    on<RemoveArticle>(onRemoveArticle);
    on<SaveArticle>(onSaveArticle);
  }

  void onGetSavedArticle(
      GetSavedArticles event, Emitter<LocalArticleState> emit) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }

  onRemoveArticle(
      RemoveArticle removeArticle, Emitter<LocalArticleState> emit) async {
    await _removeArticleUseCase(params: removeArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }

  onSaveArticle(
      SaveArticle saveArticle, Emitter<LocalArticleState> emit) async {
    await _saveArticleUseCase(params: saveArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }
}
