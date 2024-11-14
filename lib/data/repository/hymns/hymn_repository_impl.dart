import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:m_tunes/data/models/Category/category.dart';
import 'package:m_tunes/data/sources/hymns/hymns_firebase_service.dart';
import 'package:m_tunes/domain/entities/category/category.dart';
import 'package:m_tunes/domain/entities/hymns/hymns.dart';
import 'package:m_tunes/domain/repository/hymns/hymns.dart';
import 'package:m_tunes/service_locator.dart';



class HymnRepositoryImpl extends HymnsRepository {


  @override
  Future<Either<String, List<HymnEntity>>> getHymnsByCategory(
      String category) async {
    try {
      return await sl<HymnFirebaseService>().getHymnsByCategory(category);
    } catch (e) {
      print('Error fetching hymns for category $category: $e');
      return Left('Failed to fetch hymns for category $category');
    }
  }

  @override
  Future<Either<String, List<CategoryEntity>>> getHymnCategories() async {
    try {
      var data = await FirebaseFirestore.instance.collection('Categories').get();

      List<CategoryEntity> categories = [];
      for (var doc in data.docs) {
        var categoryModel = CategoryModel.fromJson(doc.data());
        categories.add(categoryModel.toEntity());
      }
      return Right(categories);
    } catch (e) {
      print('Error fetching categories: $e'); // Log errors for debugging
      return Left('Failed to fetch categories from Firestore');
    }
  }


  @override
  Future<Either> addOrRemoveFavoriteHymns(String hymnId) async{
    return await sl<HymnFirebaseService>().addOrRemoveFavoriteHymns(hymnId);
  }

  @override
  Future<bool> isFavoriteHymn(String hymnId) async {
    return await sl<HymnFirebaseService>().IsFavoriteHymn(hymnId);

  }
}
