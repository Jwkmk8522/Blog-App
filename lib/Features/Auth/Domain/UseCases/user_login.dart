import 'package:blog_app/Core/Errors/failure.dart';
import 'package:blog_app/Core/UseCAses/usecase.dart';
import 'package:blog_app/Core/Common/Enteties/user_enteties.dart';
import 'package:blog_app/Features/Auth/Domain/Repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UseCase<UserEnteties, UserLoginParams> {
  AuthRepository authRepository;
  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, UserEnteties>> call(UserLoginParams params) async {
    return await authRepository.logInWithEmailAndPasssword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  String email;
  String password;
  UserLoginParams(this.email, this.password);
}
