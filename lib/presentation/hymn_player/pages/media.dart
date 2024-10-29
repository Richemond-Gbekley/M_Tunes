import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_tunes/common/widgets/appbar/app_bar.dart';
import 'package:m_tunes/common/widgets/favorite_button/favorite_button.dart';
import 'package:m_tunes/core/configs/constants/app_urls.dart';
import 'package:m_tunes/core/configs/theme/app_colors.dart';
import 'package:m_tunes/domain/entities/hymns/hymns.dart';
import 'package:m_tunes/presentation/hymn_player/bloc/hymn_player_cubit.dart';
import 'package:m_tunes/presentation/hymn_player/bloc/hymn_player_state.dart';

class HymnPlayerScreen extends StatelessWidget {
  final HymnEntity hymnEntity;

  const HymnPlayerScreen({
    required this.hymnEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: const Text(
          'Now Playing',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
        ),
      ),
      body: BlocProvider(
        create: (_) => HymnPlayerCubit()
          ..loadHymn(
            '${AppURLs.songfirestorage}${Uri.encodeComponent('${hymnEntity.artist}, ${hymnEntity.title}.mp3')}?${AppURLs.mediaAlt}',
          ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              _hymnCover(context), // Display cover image
              const SizedBox(height: 20), // Add space below the image
              _hymnDetail(),
              const SizedBox(height: 30), // Display hymn details
              _hymnPlayer(context), // Additional controls (e.g., play, pause) can be added here
            ],
          ),
        ),
      ),
    );
  }

  // Widget to display the hymn cover image
  Widget _hymnCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            '${AppURLs.coverfirestorage}${Uri.encodeComponent('${hymnEntity.artist}, ${hymnEntity.title}.jpeg')}?${AppURLs.mediaAlt}',
          ),
        ),
      ),
    );
  }

  // Widget to display hymn details
  Widget _hymnDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hymnEntity.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              hymnEntity.artist,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            Text(
              'Hymn Number: ${hymnEntity.hymn_number}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        FavoriteButton(
          hymnEntity: hymnEntity,
        )
      ],
    );
  }

  // Widget to display hymn player
  Widget _hymnPlayer(BuildContext context) {
    return BlocBuilder<HymnPlayerCubit, HymnPlayerState>(
      builder: (context, state) {
        if (state is HymnPlayerLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HymnPlayerLoaded) {
          final cubit = context.read<HymnPlayerCubit>();
          return Column(
            children: [
              Slider(
                value: cubit.hymnPosition.inSeconds.toDouble(),
                min: 0.0,
                max: cubit.hymnDuration.inSeconds > 0
                    ? cubit.hymnDuration.inSeconds.toDouble()
                    : 1.0,
                onChanged: (value) {
                  cubit.audioPlayer.seek(Duration(seconds: value.toInt()));
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDuration(cubit.hymnPosition)),
                  Text(formatDuration(cubit.hymnDuration)),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  cubit.playOrPauseSong();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Icon(
                    cubit.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
