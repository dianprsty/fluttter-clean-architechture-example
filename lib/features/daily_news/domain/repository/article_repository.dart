import 'package:clean_architecture_example/core/resources/data_state.dart';
import 'package:clean_architecture_example/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  // API Method
  Future<DataState<List<ArticleEntity>>> getNewsArticles();

  // Database Method
  Future<List<ArticleEntity>> getSavedArticles();

  Future<void> saveArticle(ArticleEntity article);

  Future<void> removeArticle(ArticleEntity article);
}
