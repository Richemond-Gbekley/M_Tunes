import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_tunes/presentation/root/bloc/category_state.dart';
import 'package:m_tunes/presentation/root/bloc/hymns_song_cubit.dart';
import 'package:m_tunes/presentation/root/bloc/hymns_song_state.dart';
import 'package:m_tunes/domain/entities/category/category.dart';
import 'package:m_tunes/domain/entities/hymns/hymns.dart';
import 'package:m_tunes/presentation/root/widgets/hymn_detail.dart';
import 'package:m_tunes/common/widgets/favorite_button/favorite_button.dart';

class HymnsScreen extends StatelessWidget {
  const HymnsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HymnsCubit()..loadCategories(), // Load categories on screen initialization
      child: BlocBuilder<HymnsCubit, HymnsState>(
        builder: (context, state) {
          if (state is HymnsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HymnsLoadFailure) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is HymnCategoriesLoaded) {
            return _buildCategoryList(context, state.categories.cast<CategoryEntity>());
          } else if (state is HymnsLoaded) {
            return _buildHymnList(context, state.hymns);
          } else {
            return const Center(child: Text("No Categories Found")); // Default message
          }
        },
      ),
    );
  }

  // Method to build the category list
  Widget _buildCategoryList(BuildContext context, List<CategoryEntity> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(
              category.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // Load hymns by category with loading state
              context.read<HymnsCubit>().getHymnsByCategory(category.id);
            },
          ),
        );
      },
    );
  }

  // Method to build the hymn list
  Widget _buildHymnList(BuildContext context, List<HymnEntity> hymns) {
    return Scaffold(
      body: Column(
        children: [
          _HymnHeader(onBackPressed: () {
            context.read<HymnsCubit>().loadCategories(); // Reload categories on back
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
                          FavoriteButton(hymnEntity: hymn),
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
      padding: const EdgeInsets.only(top: 16, left: 16),
      child: Row(
        children: [
          IconButton(
            onPressed: onBackPressed,
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          const SizedBox(width: 8),
          const Text(
            'Hymns',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
