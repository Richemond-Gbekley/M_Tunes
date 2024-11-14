import 'package:m_tunes/core/usecase/usecase.dart';
import 'package:m_tunes/domain/repository/hymns/hymns.dart';
import '../../../service_locator.dart';

class IsFavoriteHymnUseCase implements UseCase<bool,String> {
  @override
  Future<bool> call({String ? params}) async {
    return await sl<HymnsRepository>().isFavoriteHymn(params!);
  }


}