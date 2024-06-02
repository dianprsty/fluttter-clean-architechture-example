import 'dart:io';

import 'package:clean_architecture_example/core/constant/constant.dart';
import 'package:clean_architecture_example/core/resources/data_state.dart';
import 'package:clean_architecture_example/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:clean_architecture_example/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:clean_architecture_example/features/daily_news/data/models/article.dart';
import 'package:clean_architecture_example/features/daily_news/domain/entities/article.dart';
import 'package:clean_architecture_example/features/daily_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabse _appDatabse;
  ArticleRepositoryImpl(this._newsApiService, this._appDatabse);
  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSucces(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() {
    return _appDatabse.articleDao.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabse.articleDao
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabse.articleDao
        .inserArticle(ArticleModel.fromEntity(article));
  }
}
