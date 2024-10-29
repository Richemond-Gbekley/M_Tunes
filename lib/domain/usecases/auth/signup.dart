import 'package:dartz/dartz.dart';
import 'package:m_tunes/core/usecase/usecase.dart';
import 'package:m_tunes/data/models/auth/create_user_req.dart';
import 'package:m_tunes/domain/repository/auth/auth.dart';
import 'package:m_tunes/service_locator.dart';

class SignupUseCase implements UseCase<Either,CreateUserReq> {


  @override
  Future<Either> call({CreateUserReq ? params}) async {
    return sl<AuthRepository>().signup(params!);
  }

}