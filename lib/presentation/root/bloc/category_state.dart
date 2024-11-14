import 'package:m_tunes/domain/entities/category/category.dart';
import 'package:m_tunes/presentation/root/bloc/hymns_song_state.dart';

class HymnCategoriesLoaded extends HymnsState {
  final List<CategoryEntity> categories; // Change this to the correct type

  HymnCategoriesLoaded({required this.categories});
}


