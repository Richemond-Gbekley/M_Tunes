import 'package:m_tunes/domain/entities/category/category.dart';

class CategoryModel {
  final String name; // Adjust according to your Firestore data

  CategoryModel({required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] ?? '', // Ensure you handle missing data
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(name: name, id: ''); // Ensure this matches your entity
  }
}

