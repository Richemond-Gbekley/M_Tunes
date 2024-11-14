import 'package:m_tunes/data/models/Category/category.dart';
import 'package:m_tunes/local_database.dart';

Future<List<CategoryModel>> loadCategories() async {
  final db = await LocalDatabase.instance;
  final categoriesData = await db.getCategories();

  // Print the data retrieved from SQLite
  for (var category in categoriesData) {
    print('SQLite Data - ID: ${category['id']}, Name: ${category['name']}');
  }

  return categoriesData.map((data) => CategoryModel.fromJson(data)).toList();
}
