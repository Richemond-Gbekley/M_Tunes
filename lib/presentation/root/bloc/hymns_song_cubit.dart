import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_tunes/domain/entities/hymns/hymns.dart';
import 'package:m_tunes/domain/entities/category/category.dart';
import 'package:m_tunes/local_database.dart';
import 'package:m_tunes/presentation/root/bloc/category_state.dart';
import 'package:m_tunes/presentation/root/bloc/hymns_song_state.dart';

class HymnsCubit extends Cubit<HymnsState> {
  HymnsCubit() : super(HymnsInitial());

  // Method to load categories from SQLite
  Future<void> loadCategories() async {
    try {
      emit(HymnsLoading());
      final categoryMaps = await LocalDatabase.instance.getCategories();
      final categories = categoryMaps.map((map) => CategoryEntity.fromMap(map)).toList();

      // Sync hymns from Firebase to SQLite before loading categories
      await syncHymnsFromFirebase();

      emit(HymnCategoriesLoaded(categories: categories));
    } catch (e) {
      emit(HymnsLoadFailure(message: e.toString()));
    }
  }


  // Method to sync hymns from Firebase to SQLite
  Future<void> syncHymnsFromFirebase() async {
    try {
      emit(HymnsLoading());
      final firebaseCollection = FirebaseFirestore.instance.collection('hymns');
      final snapshot = await firebaseCollection.get();

      for (var doc in snapshot.docs) {
        final data = doc.data();
        print("Fetched hymn: ${data['title']}"); // Print hymn title for debugging
      }

      // Continue with the rest of the code...
    } catch (e) {
      emit(HymnsLoadFailure(message: e.toString()));
    }
  }


  // Method to load hymns by category from SQLite
  Future<void> getHymnsByCategory(String categoryId) async {
    try {
      emit(HymnsLoading());
      final hymnMaps = await LocalDatabase.instance.getHymnsByCategory(categoryId);
      final hymns = hymnMaps.map((map) => HymnEntity.fromMap(map)).toList();
      emit(HymnsLoaded(hymns: hymns));
    } catch (e) {
      emit(HymnsLoadFailure(message: e.toString()));
    }
  }

  // Optional real-time listener for Firebase updates
  void listenToFirebaseUpdates() {
    final firebaseCollection = FirebaseFirestore.instance.collection('hymns');
    firebaseCollection.snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added || change.type == DocumentChangeType.modified) {
          LocalDatabase.instance.saveHymn(change.doc.data()!);
        } else if (change.type == DocumentChangeType.removed) {
          LocalDatabase.instance.deleteHymn(change.doc.id);
        }
      }
    });
  }
}
