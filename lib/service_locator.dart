import 'package:get_it/get_it.dart';
import 'package:m_tunes/data/repository/auth/auth_repository_impl.dart';
import 'package:m_tunes/data/repository/hymns/hymn_repository_impl.dart';
import 'package:m_tunes/data/sources/auth/auth_firebase_service.dart';
import 'package:m_tunes/data/sources/hymns/hymns_firebase_service.dart';
import 'package:m_tunes/domain/repository/auth/auth.dart';
import 'package:m_tunes/domain/repository/hymns/hymns.dart';
import 'package:m_tunes/domain/usecases/auth/login.dart';
import 'package:m_tunes/domain/usecases/auth/signup.dart';
import 'package:m_tunes/domain/usecases/hymns/add_or_remove_favorite_hymn.dart';
import 'package:m_tunes/domain/usecases/hymns/get_hymn_categories.dart';
import 'package:m_tunes/domain/usecases/hymns/get_hymns_by_category.dart';
import 'package:m_tunes/domain/usecases/hymns/get_new_hymns.dart';
import 'package:m_tunes/domain/usecases/hymns/is_favorite_hymn.dart';
final sl = GetIt.instance;

Future<void>  initializeDependencies() async {


  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<HymnFirebaseService>(
      HymnFirebaseServiceImpl()
  );



    sl.registerSingleton<AuthRepository>(
        AuthRepositoryImpl()
    );

  sl.registerSingleton<HymnsRepository>(
        HymnRepositoryImpl()
  );

  sl.registerSingleton<SignupUseCase>(
      SignupUseCase()
  );

  sl.registerSingleton<LoginUseCase>(
      LoginUseCase()
  );


  sl.registerSingleton<GetHymnCategoriesUseCase>(
      GetHymnCategoriesUseCase()
  );

  sl.registerSingleton<AddOrRemoveFavoriteHymnUseCase>(
      AddOrRemoveFavoriteHymnUseCase()
  );

  sl.registerSingleton<IsFavoriteHymnUseCase>(
      IsFavoriteHymnUseCase()
  );

  sl.registerFactory(() => GetHymnsByCategoryUseCase(sl<HymnsRepository>()));




  // Register UseCase

}



