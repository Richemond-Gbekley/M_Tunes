import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_tunes/presentation/hymn_player/bloc/hymn_player_state.dart';

class HymnPlayerCubit extends Cubit<HymnPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration hymnDuration = Duration.zero;
  Duration hymnPosition = Duration.zero;
  bool isPlaying = false;

  HymnPlayerCubit() : super(HymnPlayerLoading()) {
    // Listen to the position updates
    audioPlayer.onPositionChanged.listen((position) {
      hymnPosition = position;
      updateHymnPlayer();
    });

    // Listen to the duration updates
    audioPlayer.onDurationChanged.listen((duration) {
      hymnDuration = duration;
      updateHymnPlayer();
    });

    // Listen to the player state changes and update isPlaying accordingly
    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = (state == PlayerState.playing);
      emit(HymnPlayerLoaded());
    });
  }

  void updateHymnPlayer() {
    emit(HymnPlayerLoaded());
  }

  Future<void> loadHymn(String url) async {
    try {
      await audioPlayer.setSourceUrl(url);
      emit(HymnPlayerLoaded());
    } catch (e) {
      emit(HymnPlayerFailure());
    }
  }

  void playOrPauseSong() {
    if (isPlaying) {
      audioPlayer.pause();
    } else {
      audioPlayer.resume();
    }
    emit(HymnPlayerLoaded());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
