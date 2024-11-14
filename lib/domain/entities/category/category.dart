// category.dart
class CategoryEntity {
  final String id; // Make sure this matches the actual field name in your database
  final String name;

  CategoryEntity({required this.id, required this.name});

  // Constructor to create CategoryEntity from a Map
  factory CategoryEntity.fromMap(Map<String, dynamic> map) {
    return CategoryEntity(
      id: map['id'],
      name: map['name'],
    );
  }
}
