import 'package:dartz/dartz.dart';
import 'package:m_tunes/domain/entities/category/category.dart';
import 'package:m_tunes/domain/entities/hymns/hymns.dart';

abstract class HymnsRepository {
  Future<Either<String, List<CategoryEntity>>> getHymnCategories();  // Fetch hymn categories
  Future<Either<String, List<HymnEntity>>> getHymnsByCategory(String category);  // Fetch hymns by category
  Future<Either> addOrRemoveFavoriteHymns(String hymnId);
  Future<bool> isFavoriteHymn(String hymnId);
}
