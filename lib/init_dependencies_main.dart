part of 'init_dependencies.dart';

final serviceLocater = GetIt.instance;

Future<void> initDependencies() async {
  _authInit();
  _blogInit();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supaBaseUrl,
    anonKey: AppSecrets.supaBaseAnon,
  );
  serviceLocater.registerLazySingleton(() => supabase.client);

  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;
  serviceLocater.registerLazySingleton(() => Hive.box(name: 'Blogs'));

  serviceLocater.registerFactory(() => InternetConnection());
  //Core
  serviceLocater.registerLazySingleton(() => AppUserCubit());
  serviceLocater.registerLazySingleton(
    () => LogoutUserCubit(supabase: serviceLocater()),
  );

  serviceLocater.registerFactory<ConnectionCheker>(
    () => ConnectionCheckerImpl(internetConnection: serviceLocater()),
  );
}

void _blogInit() {
  // DataSources

  serviceLocater
    ..registerFactory<BlogRemotedatasource>(
      () => BlocRemotedatasoursceImpl(supabaseClient: serviceLocater()),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocaldatasourceImpl(box: serviceLocater()),
    )
    // Repositery
    ..registerFactory<BlogRepositery>(
      () => BlogRepositeryimpl(
        blogRemotedatasource: serviceLocater(),
        connectionCheker: serviceLocater(),
        blogLocalDataSource: serviceLocater(),
      ),
    )
    // UseCases
    ..registerFactory(() => UploadBlog(blogRepositery: serviceLocater()))
    ..registerFactory(() => GetAllBlogs(blogRepositery: serviceLocater()))
    // Bloc
    ..registerLazySingleton(
      () =>
          BlogBloc(uploadBlog: serviceLocater(), getAllBlog: serviceLocater()),
    );
}

void _authInit() {
  // DataSources
  serviceLocater
    ..registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDataSourceImpl(serviceLocater()),
    )
    // Repositories
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDatasource: serviceLocater(),
        connectionCheker: serviceLocater(),
      ),
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
