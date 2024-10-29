import 'package:dartz/dartz.dart';
import 'package:m_tunes/data/models/auth/create_user_req.dart';
import 'package:m_tunes/data/models/auth/login_user_req.dart';
import 'package:m_tunes/data/sources/auth/auth_firebase_service.dart';
import 'package:m_tunes/domain/repository/auth/auth.dart';
import 'package:m_tunes/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository{


  @override
  Future<Either> login(LoginUserReq loginUserReq) async {
    return await sl<AuthFirebaseService>().login(loginUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
   return await sl<AuthFirebaseService>().signup(createUserReq);
  }

}
