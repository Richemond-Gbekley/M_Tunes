import 'package:dartz/dartz.dart';
import 'package:m_tunes/core/usecase/usecase.dart';
import 'package:m_tunes/data/models/auth/login_user_req.dart';
import 'package:m_tunes/domain/repository/auth/auth.dart';
import 'package:m_tunes/service_locator.dart';

class LoginUseCase implements UseCase<Either,LoginUserReq> {


  @override
  Future<Either> call({LoginUserReq ? params}) async {
    return sl<AuthRepository>().login(params!);
  }

}