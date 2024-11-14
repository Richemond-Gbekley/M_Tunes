import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_tunes/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:m_tunes/domain/usecases/hymns/add_or_remove_favorite_hymn.dart';
import 'package:m_tunes/service_locator.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {

  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  Future<void> favoriteButtonUpdated(String songId) async {

    var result = await sl<AddOrRemoveFavoriteHymnUseCase>().call(
        params: songId
    );
    result.fold(
          (l){},
          (isFavorite){
        emit(
            FavoriteButtonUpdated(
                isFavorite: isFavorite
            )
        );
      },
    );
  }
}