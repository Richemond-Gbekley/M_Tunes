import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:m_tunes/data/models/Category/category.dart';
import 'package:m_tunes/data/models/hymns/hymns.dart';
import 'package:m_tunes/domain/entities/category/category.dart';
import 'package:m_tunes/domain/entities/hymns/hymns.dart';
import 'package:m_tunes/domain/usecases/hymns/is_favorite_hymn.dart';
import 'package:m_tunes/service_locator.dart';



abstract class HymnFirebaseService {
  Future<Either<String, List<HymnEntity>>> getHymnsByCategory(String category);
  Future<Either<String, List<CategoryEntity>>> getHymnCategories(); // Updated to CategoryEntity
  Future<Either> addOrRemoveFavoriteHymns(String hymnId);
  Future<bool> IsFavoriteHymn(String hymnId);

}

class HymnFirebaseServiceImpl extends HymnFirebaseService {


  @override
  Future<Either<String, List<HymnEntity>>> getHymnsByCategory(String category) async {
    try {
      List<HymnEntity> hymns = [];
      var data = await FirebaseFirestore.instance.collection('Hymns').get();

      // Convert user input to lowercase and trim any whitespace
      String normalizedCategory = category.toLowerCase().trim();

      for (var element in data.docs) {
        var hymnModel = HymnModel.fromJson(element.data());

        bool isFavorite = await sl<IsFavoriteHymnUseCase>().call(
          params : element.reference.id
        );
        hymnModel.isFavorite = isFavorite;
        hymnModel.hymnId = element.reference.id;


        // Check if category exists and matches
        if (hymnModel.category != null && hymnModel.category!.toLowerCase().trim() == normalizedCategory) {
          hymns.add(hymnModel.toEntity());
        }
      }

      if (hymns.isEmpty) {
        print("No hymns found for category: $category");
      } else {
        print("Hymns loaded for category $category: ${hymns.length}");
      }

      return Right(hymns);
    } catch (e) {
      print("Error fetching hymns: $e");
      return Left('An error occurred while fetching hymns for category $category');
    }
  }


  @override
  Future<Either<String, List<CategoryEntity>>> getHymnCategories() async {
    try {
      List<CategoryEntity> categories = [];

      // Fetch data from Firestore
      var data = await FirebaseFirestore.instance.collection('Categories').get();

      // Log raw Firestore data for debugging
     // Check if the collection is empty
      if (data.docs.isEmpty) {
        print('No categories found in Firestore.');
        return Left('No categories found in Firestore.');
      }

      // Extract and convert the 'name' field from each document
      for (var doc in data.docs) {
        var categoryModel = CategoryModel.fromJson(doc.data());

        // Log the category name for debugging
        print('Category Name from Document ${doc.id}: ${categoryModel.name}');

        // Ensure the category model has a name before adding it
        if (categoryModel.name != null && categoryModel.name.isNotEmpty) {
          categories.add(categoryModel.toEntity());
        } else {
          print('Document ${doc.id} does not contain a valid name field.');
        }
      }

      // Log the final categories list
      print('Final categories list: $categories');

      if (categories.isEmpty) {
        return Left('No valid categories were found.');
      }

      return Right(categories);
    } catch (e) {
      print('Error fetching categories: $e');
      return Left('Failed to load categories from Firestore');
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteHymns(String hymnId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late  bool isFavorite;
      var user = await firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteHymns = await firebaseFirestore.collection('users')
          .doc(uId).collection('Favorites')
          .where(
          'hymnId', isEqualTo: hymnId
      ).get();

      if (favoriteHymns.docs.isNotEmpty) {
        await favoriteHymns.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await firebaseFirestore.collection('users')
            .doc(uId)
            .collection('Favorites')
            .add(
            {
              'hymnId': hymnId,
              'addedDate': Timestamp.now()
            }
        );
        isFavorite = true;
      }
      return Right(isFavorite);
    }
    catch (e){
      return Left('An error occured');
  }
  }

  @override
  Future<bool> IsFavoriteHymn(String hymnId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;




      var user = await firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteHymns = await firebaseFirestore.collection('users')
          .doc(uId).collection('Favorites')
          .where(
          'hymnId', isEqualTo: hymnId
      ).get();

      if (favoriteHymns.docs.isNotEmpty) {
       return true;
      } else {
        return false;
      }

    }
    catch (e){
      return false;
    }
  }


}



