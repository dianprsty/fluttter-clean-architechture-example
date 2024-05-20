import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture_example/core/resources/data_state.dart';
import 'package:clean_architecture_example/features/daily_news/domain/entities/article.dart';
import 'package:clean_architecture_example/features/daily_news/domain/usecases/get_article.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_article_event.dart';
part 'remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticleBloc(this._getArticleUseCase)
      : super(const RemoteArticleLoading()) {
    on<GetArticlesEvent>(onGetArticles);
  }

  void onGetArticles(
      GetArticlesEvent event, Emitter<RemoteArticleState> emit) async {
    try {
      log("[BLOC] GET ARTICLE FROM API");
      final dataState = await _getArticleUseCase();

      if (dataState is DataSucces && dataState.data!.isNotEmpty) {
        log("[BLOC] SUCCESS GET ARTICLE");

        emit(RemoteArticleDone(dataState.data!));
      }

      if (dataState is DataFailed) {
        log("[BLOC] FAILED GET ARTICLE");
        emit(RemoteArticleError(dataState.error!));
      }
    } catch (e) {
      log("[ERROR] [REMOTE ARTICLE BLOC] ${e.toString()}");
      emit(RemoteArticleError(
        DioException.connectionError(
            requestOptions: RequestOptions(), reason: "failed connect to api"),
      ));
    }
  }
}
