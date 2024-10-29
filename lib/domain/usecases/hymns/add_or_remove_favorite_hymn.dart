import 'package:dartz/dartz.dart';
import 'package:m_tunes/core/usecase/usecase.dart';
import 'package:m_tunes/domain/repository/hymns/hymns.dart';

import '../../../service_locator.dart';

class AddOrRemoveFavoriteHymnUseCase implements UseCase<Either,String> {
  @override
  Future<Either> call({String ? params}) async {
    return await sl<HymnsRepository>().addOrRemoveFavoriteHymns(params!);
  }

}