import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_tunes/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:m_tunes/common/helpers/is_dark_mode.dart'; // Helper for checking dark mode
import 'package:m_tunes/common/widgets/favorite_button/favorite_button.dart';
import 'package:m_tunes/core/configs/theme/app_colors.dart';
import 'package:m_tunes/domain/entities/category/category.dart'; // Category entity import
import 'package:m_tunes/domain/entities/hymns/hymns.dart'; // Hymn entity import
import 'package:m_tunes/presentation/root/bloc/category_state.dart'; // Bloc state for categories
import 'package:m_tunes/presentation/root/bloc/hymns_song_cubit.dart'; // Cubit for managing hymn state
import 'package:m_tunes/presentation/root/bloc/hymns_song_state.dart';
import 'package:m_tunes/presentation/root/widgets/hymn_detail.dart'; // State management for hymns

// Main screen for displaying hymns
class HymnsScreen extends StatelessWidget {
  const HymnsScreen({super.key}); // Constructor for the HymnsScreen

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HymnsCubit()..loadCategories(), // Initializes HymnsCubit and loads categories
      child: BlocBuilder<HymnsCubit, HymnsState>(
        builder: (context, state) {
          // Handling different states of hymns
          if (state is HymnsLoading) {
            return const Center(child: CircularProgressIndicator()); // Loading indicator
          } else if (state is HymnsLoadFailure) {
            return Center(child: Text("Error: ${state.message}")); // Display error message
          } else if (state is HymnCategoriesLoaded) {
            // If categories are loaded successfully, display them
            return _buildCategoryList(context, state.categories.cast<CategoryEntity>());
          } else if (state is HymnsLoaded) {
            // If hymns are loaded successfully, display the hymn list
            return _buildHymnList(context, state.hymns);
          } else {
            return const Center(child: Text("No Hymns Found")); // Fallback message for no hymns
          }
        },
      ),
    );
  }

  // Method to build the category list
  Widget _buildCategoryList(BuildContext context, List<CategoryEntity> categories) {
    return ListView.builder(
      itemCount: categories.length, // Number of categories
      itemBuilder: (context, index) {
        final category = categories[index]; // Get the category at the current index
        return Card(
          elevation: 3, // Shadow effect for the card
          margin: const EdgeInsets.symmetric(vertical: 8), // Vertical spacing for cards
          child: ListTile(
            title: Text(
              category.name, // Display the category name
              style: const TextStyle(fontWeight: FontWeight.bold), // Bold text style
            ),
            onTap: () {
              print("Selected category: ${category.name}"); // Debug print for selected category
              // Fetch hymns based on selected category
              context.read<HymnsCubit>().getHymnsByCategory(category.name);
            },
          ),
        );
      },
    );
  }

  // Method to build the hymn list
  // Method to build the hymn list
  Widget _buildHymnList(BuildContext context, List<HymnEntity> hymns) {
    return Scaffold(
      body: Column(
        children: [
          _HymnHeader(onBackPressed: () {
            context.read<HymnsCubit>().loadCategories();
          }),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: hymns.length,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final hymn = hymns[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to HymnDetailScreen with the selected hymn
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HymnDetailScreen(hymn: hymn),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hymn.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                hymn.artist,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            hymn.hymn_number.toString().replaceAll('.', ':'),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 20),
                          // FavoriteButton(hymnEntity: hymn),
                         FavoriteButton(
                           hymnEntity:  hymns[index],

                         )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Header widget for the hymn list with back button
  Widget _HymnHeader({required VoidCallback onBackPressed}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16), // Padding for the header
      child: Row(
        children: [
          IconButton(
            onPressed: onBackPressed, // Back button action
            icon: const Icon(Icons.arrow_back_ios_new), // Back arrow icon
          ),
          const SizedBox(width: 8), // Spacing between button and title
          const Text(
            'Hymns',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), // Title style
          ),
        ],
      ),
    );
  }
}
