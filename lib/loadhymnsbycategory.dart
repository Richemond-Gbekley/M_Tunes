import 'package:m_tunes/data/models/hymns/hymns.dart';
import 'package:m_tunes/local_database.dart';

Future<List<HymnModel>> loadHymnsByCategory(String categoryId) async {
  final db = await LocalDatabase.instance;
  final hymnsData = await db.getHymnsByCategory(categoryId);

  // Print the data retrieved from SQLite
  for (var hymn in hymnsData) {
    print('SQLite Data - ID: ${hymn['id']}, Title: ${hymn['title']}, Artist: ${hymn['artist']}');
  }

  return hymnsData.map((data) => HymnModel.fromJson(data)).toList();
}
