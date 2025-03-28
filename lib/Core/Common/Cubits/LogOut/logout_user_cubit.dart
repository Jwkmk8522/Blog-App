import 'package:blog_app/Core/Errors/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'logout_user_state.dart';

class LogoutUserCubit extends Cubit<LogoutUserState> {
  final Supabase supabase;
  LogoutUserCubit({required this.supabase}) : super(LogoutUserInitial());
  Future<void> logOutUSer() async {
    emit(LogOutUserLoading());
    try {
      await supabase.client.auth.signOut();
      emit(LogOutUserSuccess());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
