import 'package:dartz/dartz.dart';
import 'package:m_tunes/core/usecase/usecase.dart';
import 'package:m_tunes/domain/entities/category/category.dart';
import 'package:m_tunes/domain/repository/hymns/hymns.dart';
import 'package:m_tunes/service_locator.dart';



class NoParams {}


class GetHymnCategoriesUseCase implements UseCase<Either<String, List<CategoryEntity>>, NoParams> {

  @override
  Future<Either<String, List<CategoryEntity>>> call({NoParams? params}) async {
    return await sl<HymnsRepository>().getHymnCategories();
  }
}

