import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:m_tunes/load_categories.dart';
import 'package:m_tunes/loadhymnsbycategory.dart';

import 'package:m_tunes/local_database.dart';
import 'package:m_tunes/presentation/root/bloc/hymns_song_cubit.dart';
import 'package:m_tunes/presentation/splash/pages/splash.dart';
import 'package:m_tunes/service_locator.dart';
import 'package:m_tunes/sync_hymn_category.dart';
import 'package:path_provider/path_provider.dart';
import 'package:m_tunes/core/configs/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  await Firebase.initializeApp();

  await LocalDatabase.instance.database; // Ensure the database is initialized


  await initializeDependencies();

  // Synchronize hymn categories and load data
  await syncHymnCategories();
  await loadCategories();

  // It may be unnecessary to call loadHymnsByCategory here unless you want to load all hymns
  // You may want to specify a categoryId
  

  runApp(const MTunes());

}

class MTunes extends StatelessWidget {
  const MTunes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),



      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      );
  }
}