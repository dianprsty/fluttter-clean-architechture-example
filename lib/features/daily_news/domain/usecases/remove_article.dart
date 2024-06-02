import 'package:clean_architecture_example/core/usecases/usecase.dart';
import 'package:clean_architecture_example/features/daily_news/domain/entities/article.dart';
import 'package:clean_architecture_example/features/daily_news/domain/repository/article_repository.dart';

class RemoveArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;

  RemoveArticleUseCase(this._articleRepository);
  @override
  Future<void> call({ArticleEntity? params}) {
    return _articleRepository.removeArticle(params!);
  }
}
