import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();
  static Database? _database;

  // Constants for table names
  static const String categoriesTable = 'categories';
  static const String hymnsTable = 'hymns';

  LocalDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('hymns.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print('Initializing database at path: $path');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    print('Creating tables in the database...');
    await db.execute('''  
      CREATE TABLE $categoriesTable (
        id TEXT PRIMARY KEY,
        name TEXT
      )
    ''');
    print('Categories table created.');

    await db.execute('''  
      CREATE TABLE $hymnsTable (
        id TEXT PRIMARY KEY,
        title TEXT,
        artist TEXT,
        categoryId TEXT,
        coverImageUrl TEXT,
        audioUrl TEXT,
        duration REAL,
        hymnNumber INTEGER,
        lyrics TEXT,
        releaseDate TEXT,
        FOREIGN KEY (categoryId) REFERENCES $categoriesTable (id)
      )
    ''');
    print('Hymns table created.');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('Upgrading database from version $oldVersion to $newVersion');
    if (oldVersion < 2) {
      // Handle upgrade logic if needed
    }
  }

  Future<void> insertCategory(Map<String, dynamic> category) async {
    final db = await instance.database;
    try {
      await db.insert(categoriesTable, category, conflictAlgorithm: ConflictAlgorithm.replace);
      print('Inserted category: ${category['name']} with ID: ${category['id']}');
    } catch (e) {
      print('Error inserting category: $e');
    }
  }

  Future<void> saveHymn(Map<String, dynamic> hymn) async {
    final db = await instance.database;
    if (hymn['releaseDate'] is Timestamp) {
      hymn['releaseDate'] = (hymn['releaseDate'] as Timestamp).toDate().toIso8601String();
    }
    try {
      await db.insert(hymnsTable, hymn, conflictAlgorithm: ConflictAlgorithm.replace);
      print('Saved hymn: ${hymn['title']} with ID: ${hymn['id']}');
    } catch (e) {
      print('Error saving hymn: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await instance.database;
    try {
      final categories = await db.query(categoriesTable);
      print('Retrieved categories: ${categories.length} found');
      return categories;
    } catch (e) {
      print('Error retrieving categories: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getHymns() async {
    final db = await instance.database;
    try {
      final hymns = await db.query(hymnsTable);
      print('Retrieved all hymns: ${hymns.length} found');
      return hymns;
    } catch (e) {
      print('Error retrieving hymns: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getHymnsByCategory(String categoryId) async {
    final db = await instance.database;
    try {
      final hymns = await db.query(hymnsTable, where: 'categoryId = ?', whereArgs: [categoryId]);
      print('Retrieved hymns for category ID: $categoryId, ${hymns.length} found');
      return hymns;
    } catch (e) {
      print('Error retrieving hymns: $e');
      return [];
    }
  }

  Future<void> deleteHymn(String hymnId) async {
    final db = await instance.database;
    try {
      await db.delete(hymnsTable, where: 'id = ?', whereArgs: [hymnId]);
      print('Deleted hymn with ID: $hymnId');
    } catch (e) {
      print('Error deleting hymn: $e');
    }
  }

  Future<void> updateHymn(Map<String, dynamic> hymn) async {
    final db = await instance.database;
    if (hymn['releaseDate'] is Timestamp) {
      hymn['releaseDate'] = (hymn['releaseDate'] as Timestamp).toDate().toIso8601String();
    }
    try {
      await db.update(hymnsTable, hymn, where: 'id = ?', whereArgs: [hymn['id']]);
      print('Updated hymn with ID: ${hymn['id']}');
    } catch (e) {
      print('Error updating hymn: $e');
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
    print('Database closed.');
  }
}
