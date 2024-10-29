import 'package:m_tunes/domain/entities/hymns/hymns.dart';

abstract class HymnsState {}

  class HymnsLoading extends HymnsState {}

  class HymnsLoaded extends HymnsState   {

  final List<HymnEntity> hymns;
  HymnsLoaded ({required this.hymns});
  }

class HymnsLoadFailure extends HymnsState {
  final String message;

  HymnsLoadFailure({this.message = 'An unknown error occurred.'});
}


