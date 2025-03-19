import 'package:blog_app/Core/Common/Cubits/AppUser/app_user_cubit.dart';
import 'package:blog_app/Core/Secrets/app_secrets.dart';
import 'package:blog_app/Features/Auth/Data/DataSource/auth_remote_datasource.dart';
import 'package:blog_app/Features/Auth/Data/Repositeries/auth_repository_impl.dart';
import 'package:blog_app/Features/Auth/Domain/Repositories/auth_repository.dart';
import 'package:blog_app/Features/Auth/Domain/UseCases/current_user.dart';
import 'package:blog_app/Features/Auth/Domain/UseCases/user_login.dart';
import 'package:blog_app/Features/Auth/Domain/UseCases/user_signup.dart';
import 'package:blog_app/Features/Auth/Presentation/bloc/auth_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocater = GetIt.instance;

Future<void> initDependencies() async {
  _authInit();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supaBaseUrl,
    anonKey: AppSecrets.supaBaseAnon,
  );
  serviceLocater.registerLazySingleton(() => supabase.client);
  //Core
  serviceLocater.registerLazySingleton(() => AppUserCubit());
}

void _authInit() {
  // DataSources
  serviceLocater
    ..registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDataSourceImpl(serviceLocater()),
    )
    // Repositories
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocater()),
    )
    // UseCases
    ..registerFactory(() => UserSignup(serviceLocater()))
    ..registerFactory(() => UserLogin(serviceLocater()))
    ..registerFactory(() => CurrentUser(serviceLocater()))
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignup: serviceLocater(),
        userLogin: serviceLocater(),
        currentUser: serviceLocater(),
        appUserCubit: serviceLocater(),
      ),
    );
}
