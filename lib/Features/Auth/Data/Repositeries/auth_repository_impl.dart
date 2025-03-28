import 'package:blog_app/Core/Errors/exceptions.dart';
import 'package:blog_app/Core/Errors/failure.dart';
import 'package:blog_app/Core/Network/connection_cheker.dart';
import 'package:blog_app/Core/constants/constants.dart';

import 'package:blog_app/Features/Auth/Data/DataSource/auth_remote_datasource.dart';

import 'package:blog_app/Core/Common/Enteties/user_enteties.dart';
import 'package:blog_app/Features/Auth/Domain/Repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ConnectionCheker connectionCheker;
  final AuthRemoteDatasource remoteDatasource;
  AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.connectionCheker,
  });

  //Why i dont use _getUSer in the currentUser function. because i want to show the user is  log in or not.
  //if user is not log in then i return the failure. if i use the _getUser funtion then how i know the user
  //is not log in.mean In _getUser funtiio the return type is UserEnteties not UserEntites?.
  @override
  Future<Either<Failure, UserEnteties>> currentUser() async {
    try {
      if (!await (connectionCheker.isConnected)) {
        final session = remoteDatasource.currentUserSession;
        if (session == null) {
          return left(Failure('User is Not loged in'));
        }
        return right(
          UserEnteties(
            id: session.user.id,
            email: session.user.email!,
            name: '',
          ),
        );
      }

      final user = await remoteDatasource.getCurrentUserData();
      if (user == null) {
        return Left(Failure('User is not logged in'));
      }
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEnteties>> signUpWithEmailAndPasssword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDatasource.signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      ),
    );
  }

  @override
  Future<Either<Failure, UserEnteties>> logInWithEmailAndPasssword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDatasource.logInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, UserEnteties>> _getUser(
    Future<UserEnteties> Function() fn,
  ) async {
    try {
      if (!await (connectionCheker.isConnected)) {
        return left(Failure(Constants.noConnection));
      }
      final user = await fn();
      return Right(user);
    } on MyAuthException catch (_) {
      return Left(Failure('wrong email or password'));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
