import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:m_tunes/domain/entities/hymns/hymns.dart';
import 'package:m_tunes/domain/usecases/hymns/get_hymn_categories.dart';
import 'package:m_tunes/domain/usecases/hymns/get_hymns_by_category.dart';
import 'package:m_tunes/presentation/root/bloc/category_state.dart';
import 'package:m_tunes/presentation/root/bloc/hymns_song_state.dart';
import 'package:m_tunes/service_locator.dart';

class HymnsCubit extends Cubit<HymnsState> {
  HymnsCubit() : super(HymnsLoading());

  // Load categories and ensure it returns CategoryEntity
  Future<void> loadCategories() async {
    emit(HymnsLoading()); // Emit loading state

    var result = await sl<GetHymnCategoriesUseCase>().call(params: NoParams());

    result.fold(
          (failure) {
        print('Failed to load categories: $failure');
        emit(HymnsLoadFailure());
      },
          (categories) {
        print('Categories loaded: ${categories.length}');
        emit(HymnCategoriesLoaded(
            categories: categories)); // Ensure you are passing the correct type
      },
    );
  }


  // Load hymns by category
  Future<void> getHymnsByCategory(String category) async {
    emit(HymnsLoading());

    var result = await sl<GetHymnsByCategoryUseCase>().call(params: category);

    result.fold(
          (failure) {
        print('Failed to load hymns for category $category: $failure');
        emit(HymnsLoadFailure());
      },
          (hymns) {
        // Filter hymns by category
        List<HymnEntity> filteredHymns = hymns.where((hymn) =>
        hymn.category == category).toList();
        print('Hymns loaded for category $category: ${filteredHymns.length}');
        emit(HymnsLoaded(hymns: filteredHymns));
      },
    );
  }
}
