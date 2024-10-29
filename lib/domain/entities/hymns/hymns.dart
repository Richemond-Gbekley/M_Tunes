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
    required this.hymnId
  });
}