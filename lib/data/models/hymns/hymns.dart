import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_tunes/domain/entities/hymns/hymns.dart';

class HymnModel {
  String? artist;
  String? category;
  String? title;
  num? duration;
  Timestamp? releaseDate;
  String audioUrl;  // Changed to required
  String? lyrics;
  num? hymnNumber;  // Changed to follow camelCase
  bool? isFavorite;
  String hymnId;  // Changed to required

  // Constructor to initialize HymnModel
  HymnModel({
    required this.artist,
    required this.category,
    required this.title,
    required this.duration,
    required this.releaseDate,
    required this.audioUrl,
    required this.lyrics,
    required this.hymnNumber,
    required this.isFavorite,
    required this.hymnId,
  });

  // Factory constructor to create a HymnModel from Firestore data
  factory HymnModel.fromJson(Map<String, dynamic> data) {
    return HymnModel(
      title: data['title'] ?? 'Untitled Hymn',
      artist: data['artist'] ?? 'Unknown Artist',
      duration: data['duration'] ?? 0.0,
      releaseDate: data['releaseDate'] as Timestamp? ?? Timestamp.now(),
      category: data['category'] ?? 'Uncategorized',
      audioUrl: data['audioUrl'] ?? '',
      lyrics: data['lyrics'] ?? 'Lyrics not available',
      hymnNumber: data['hymn_number'] ?? 0,
      isFavorite: data['isFavorite'] ?? false,
      hymnId: data['hymnId'] ?? '',
    );
  }

  // Method to convert HymnModel to JSON format for Firestore
  Map<String, dynamic> toJson() {
    return {
      'title': title ?? 'Untitled Hymn',
      'artist': artist ?? 'Unknown Artist',
      'duration': duration ?? 0.0,
      'releaseDate': releaseDate ?? Timestamp.now(),
      'category': category ?? 'Uncategorized',
      'audioUrl': audioUrl,
      'lyrics': lyrics ?? 'Lyrics not available',
      'hymn_number': hymnNumber ?? 0,
      'isFavorite': isFavorite ?? false,
      'hymnId': hymnId,
    };
  }
}

// Extension to convert HymnModel to HymnEntity
extension HymnModelExtensions on HymnModel {
  HymnEntity toEntity() {
    return HymnEntity(
      title: title ?? 'Untitled Hymn',
      artist: artist ?? 'Unknown Artist',
      duration: duration ?? 0.0,
      releaseDate: releaseDate ?? Timestamp.now(),
      category: category ?? 'Uncategorized',
      lyrics: lyrics ?? 'Lyrics not available',
      audioUrl: audioUrl,
      hymn_number: hymnNumber ?? 0,
      isFavorite: isFavorite ?? false,
      hymnId: hymnId,
    );
  }
}
