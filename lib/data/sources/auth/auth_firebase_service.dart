import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:m_tunes/data/models/auth/create_user_req.dart';
import 'package:m_tunes/data/models/auth/login_user_req.dart';


abstract class AuthFirebaseService{

  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> login(LoginUserReq loginUserReq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService{


  @override
  Future<Either> login(LoginUserReq loginUserReq ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginUserReq.email,
          password: loginUserReq.password
      );

      return Right('Sign up was successful');

    } on FirebaseAuthException catch(e) {

      String message = '';
      if(e.code == 'invalid-email') {
        message = 'Not user found for that email';
      }
      if (e.code == 'invalid-credentials') {
        message = 'Wrong Password Provided' ;
      }
      return left(message);
    }
  }








  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email,
          password: createUserReq.password
      );

      FirebaseFirestore.instance.collection('users').doc(data.user?.uid)
      .set(
        {
          'name' : createUserReq.name,
          'email' : data.user?.email,
          'gender' : createUserReq.gender,
          'dob': createUserReq.dob

        }
      );

      return Right('Sign up was successful');

    } on FirebaseAuthException catch(e) {

     String message = '';
     if(e.code == 'weak-password') {
       message = 'The password is weak';
     }
     if (e.code == 'email-already-in-use') {
       message = 'An account already exist with that email' ;
     }
     return left(message);
    }
  }

}