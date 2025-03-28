import 'package:blog_app/Core/Common/Cubits/AppUser/app_user_cubit.dart';
import 'package:blog_app/Core/Common/Cubits/LogOut/logout_user_cubit.dart';
import 'package:blog_app/Core/Network/connection_cheker.dart';
import 'package:blog_app/Core/Secrets/app_secrets.dart';
import 'package:blog_app/Features/Auth/Data/DataSource/auth_remote_datasource.dart';
import 'package:blog_app/Features/Auth/Data/Repositeries/auth_repository_impl.dart';
import 'package:blog_app/Features/Auth/Domain/Repositories/auth_repository.dart';
import 'package:blog_app/Features/Auth/Domain/UseCases/current_user.dart';

import 'package:blog_app/Features/Auth/Domain/UseCases/user_login.dart';
import 'package:blog_app/Features/Auth/Domain/UseCases/user_signup.dart';
import 'package:blog_app/Features/Auth/Presentation/bloc/auth_bloc.dart';
import 'package:blog_app/Features/Blog/Data/Data_Source/blog_localdatasource.dart';
import 'package:blog_app/Features/Blog/Data/Data_Source/blog_remotedatasource.dart';
import 'package:blog_app/Features/Blog/Data/Repositeries/blog_repositeryImpl.dart';
import 'package:blog_app/Features/Blog/Domain/Repositeries/blog_repositery.dart';
import 'package:blog_app/Features/Blog/Domain/Use_Case/get_all_blogs.dart';
import 'package:blog_app/Features/Blog/Domain/Use_Case/upload_blog.dart';
import '../Features/Blog/Presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'init_dependencies_main.dart';
