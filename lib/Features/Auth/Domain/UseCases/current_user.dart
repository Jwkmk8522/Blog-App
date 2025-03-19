import 'package:blog_app/Core/Errors/failure.dart';
import 'package:blog_app/Core/UseCAses/usecase.dart';
import 'package:blog_app/Core/Common/Enteties/user_enteties.dart';
import 'package:blog_app/Features/Auth/Domain/Repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<UserEnteties, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, UserEnteties>> call(NoParams noParams) async {
    return await authRepository.currentUser();
  }
}
