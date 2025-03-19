import 'package:blog_app/Core/Errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccesType, Params> {
  Future<Either<Failure, SuccesType>> call(Params params);
}

// we have create noparams class because we have some funtion that dont take any parameter.
//like in the current_user.dart file we have a funtion that dont take any parameter.
class NoParams {}
