import 'package:blog_app/Core/Errors/failure.dart';
import 'package:blog_app/Core/UseCAses/usecase.dart';
import 'package:blog_app/Core/Common/Enteties/user_enteties.dart';
import 'package:blog_app/Features/Auth/Domain/Repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements UseCase<UserEnteties, UserSignUpParams> {
  AuthRepository authRepository;
  UserSignup(this.authRepository);
  @override
  Future<Either<Failure, UserEnteties>> call(UserSignUpParams params) async {
    // print('user signup called');
    // print('📧 Email in UseCase: ${params.email}');
    // print('👤 Name in UseCase: ${params.name}');
    // print('🔑 Password in UseCase: ${params.password}');
    return await authRepository.signUpWithEmailAndPasssword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  String name;
  String email;
  String password;
  UserSignUpParams(this.email, this.name, this.password);
}
