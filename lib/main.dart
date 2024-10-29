import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:m_tunes/presentation/splash/pages/splash.dart';
import 'package:m_tunes/service_locator.dart';
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

  await initializeDependencies();
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