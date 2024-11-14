import 'package:cloud_firestore/cloud_firestore.dart';

class HymnEntity {
  final String artist;
  final String category;
  final String title;
  final num duration;
  final Timestamp releaseDate;
  final String audioUrl;
  final String lyrics;
  final num hymn_number;
  final bool isFavorite;
  final String hymnId;

  HymnEntity({
    required this.artist,
    required this.category,
    required this.title,
    required this.duration,
    required this.releaseDate,
    required this.audioUrl,
    required this.lyrics,
    required this.hymn_number,
    required this.isFavorite,
    required this.hymnId,
  });

  // Constructor to create HymnEntity from a Map
  factory HymnEntity.fromMap(Map<String, dynamic> map) {
    return HymnEntity(
      artist: map['artist'] ?? '',
      category: map['category'] ?? '',
      title: map['title'] ?? '',
      duration: map['duration'] ?? 0,
      releaseDate: map['releaseDate'] is Timestamp
          ? map['releaseDate']
          : Timestamp.fromMillisecondsSinceEpoch(
          DateTime.parse(map['releaseDate']).millisecondsSinceEpoch),
      audioUrl: map['audioUrl'] ?? '',
      lyrics: map['lyrics'] ?? '',
      hymn_number: map['hymn_number'] ?? 0,
      isFavorite: map['isFavorite'] ?? false,
      hymnId: map['hymnId'] ?? '',
    );
  }

  // Convert HymnEntity to Map for saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      'artist': artist,
      'category': category,
      'title': title,
      'duration': duration,
      'releaseDate': releaseDate,
      'audioUrl': audioUrl,
      'lyrics': lyrics,
      'hymn_number': hymn_number,
      'isFavorite': isFavorite,
      'hymnId': hymnId,
    };
  }
}
