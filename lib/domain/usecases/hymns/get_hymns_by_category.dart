import 'package:dartz/dartz.dart';
import 'package:m_tunes/core/usecase/usecase.dart';
import 'package:m_tunes/domain/entities/hymns/hymns.dart';
import 'package:m_tunes/domain/repository/hymns/hymns.dart';

class GetHymnsByCategoryUseCase implements UseCase<Either<String, List<HymnEntity>>, String?> {
  final HymnsRepository hymnsRepository;

  GetHymnsByCategoryUseCase(this.hymnsRepository);

  @override
  Future<Either<String, List<HymnEntity>>> call({String? params}) async {
    if (params == null || params.isEmpty) {
      return Left("Category cannot be empty");
    }
    return await hymnsRepository.getHymnsByCategory(params);
  }
}
