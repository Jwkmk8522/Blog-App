import 'package:blog_app/Core/Common/Cubits/AppUser/app_user_cubit.dart';
import 'package:blog_app/Core/Themes/theme.dart';
import 'package:blog_app/Features/Auth/Presentation/Pages/signin_page.dart';
import 'package:blog_app/Features/Auth/Presentation/bloc/auth_bloc.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocater<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocater<AuthBloc>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Signup with Supabase',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            print('user is logged in ');
            return Scaffold(body: Center(child: Text('User is logged in')));
          }
          return SigninPage();
        },
      ),
    );
  }
}
