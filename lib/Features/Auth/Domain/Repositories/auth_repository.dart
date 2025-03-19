import 'package:blog_app/Core/Errors/failure.dart';
import 'package:blog_app/Core/Common/Enteties/user_enteties.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEnteties>> signUpWithEmailAndPasssword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEnteties>> logInWithEmailAndPasssword({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEnteties>> currentUser();
}
