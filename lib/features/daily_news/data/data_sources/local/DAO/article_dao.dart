import 'package:clean_architecture_example/features/daily_news/data/models/article.dart';
import 'package:floor/floor.dart';

@dao
abstract class ArticleDao {
  @Insert()
  Future<void> inserArticle(ArticleModel article);

  @delete
  Future<void> deleteArticle(ArticleModel articleModel);

  @Query("SELECT * FROM article")
  Future<List<ArticleModel>> getArticles();
}
