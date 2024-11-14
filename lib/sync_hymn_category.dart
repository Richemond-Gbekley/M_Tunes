import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_tunes/local_database.dart';

Future<void> syncHymnCategories() async {
  final db = await LocalDatabase.instance;

  // Fetch categories from Firebase
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Categories').get();

  for (var doc in snapshot.docs) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Print the data from Firebase
    print('Firebase Data - ID: ${doc.id}, Name: ${data['name']}');

    // Insert data into SQLite and confirm with a print statement
    await db.insertCategory({
      'id': doc.id,
      'name': data['name'],
    });

    print('Inserted into SQLite - ID: ${doc.id}, Name: ${data['name']}');
  }

  print('Syncing completed');
}
