import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_tunes/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:m_tunes/domain/entities/hymns/hymns.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../bloc/favorite_button/favorite_button_state.dart';

class FavoriteButton extends StatelessWidget {
  final HymnEntity hymnEntity; // Changed to lowercase
  final Function? onFavoriteChanged; // Renamed for clarity

  const FavoriteButton({
    required this.hymnEntity,
    this.onFavoriteChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          // If the initial state is loaded
          if (state is FavoriteButtonInitial) {
            return IconButton(
              onPressed: () async {
                await context.read<FavoriteButtonCubit>().favoriteButtonUpdated(hymnEntity.hymnId);
                onFavoriteChanged?.call(); // Use the callback if provided
              },
              icon: Icon(
                hymnEntity.isFavorite ? Icons.favorite : Icons.favorite_outline_outlined,
                size: 25,
                color: AppColors.darkGrey,
              ),
            );
          }

          // If the favorite button has been updated
          if (state is FavoriteButtonUpdated) {
            return IconButton(
              onPressed: () {
                context.read<FavoriteButtonCubit>().favoriteButtonUpdated(hymnEntity.hymnId);
              },
              icon: Icon(
                state.isFavorite ? Icons.favorite : Icons.favorite_outline_outlined,
                size: 25,
                color: AppColors.darkGrey,
              ),
            );
          }

          // Return a loading indicator or error message if needed
          return Container(); // Optionally replace with a loading indicator
        },
      ),
    );
  }
}
