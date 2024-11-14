import 'package:dartz/dartz.dart';
import 'package:m_tunes/data/models/auth/create_user_req.dart';
import 'package:m_tunes/data/models/auth/login_user_req.dart';

abstract class AuthRepository {
  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> login(LoginUserReq loginUserReq);
}