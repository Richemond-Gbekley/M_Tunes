import 'package:m_tunes/domain/entities/hymns/hymns.dart';

abstract class HymnsState {}

class HymnsInitial extends HymnsState {}

class HymnsLoading extends HymnsState {}

class HymnsCategoriesLoaded extends HymnsState {
  final List<String> categories;

  HymnsCategoriesLoaded({required this.categories});
}


class HymnsLoaded extends HymnsState {
  final List<HymnEntity> hymns;

  HymnsLoaded({required this.hymns});
}

class HymnsLoadFailure extends HymnsState {
  final String message;

  HymnsLoadFailure({required this.message});
}

class HymnsSynced extends HymnsState {}
