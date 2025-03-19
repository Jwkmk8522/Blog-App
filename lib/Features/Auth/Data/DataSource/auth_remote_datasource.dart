import 'package:blog_app/Core/Errors/exceptions.dart';
import 'package:blog_app/Features/Auth/Data/Modals/user_modal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//This file Directly talks to the supabase. It is the remote data source for the AuthRepository.
//It is the implementation of the AuthRemoteDatasource interface.
//It has a class AuthRemoteDataSourceImpl which implements the AuthRemoteDatasource interface.
//It has a constructor that takes the SupabaseClient as a parameter.
//Total four funtions in this file.
//1. Session? get currentUserSession =>  this funtion return the user session mean user id and emil
//2. Future<UserModel?> getCurrentUserData() => this funtion return the user updated information from supabase database not user session.
//3. Future<UserModel> signUpWithEmailAndPassword => this funtion return the user information after sign up.
//4. Future<UserModel> logInWithEmailAndPassword => this funtion return the user information after log in.

abstract interface class AuthRemoteDatasource {
  // It give us the user session mean user id and emil and
  // we use Session? mean user is log in or not mean we have user id and emial or not.
  Session? get currentUserSession;
  // we get user updated information from supabase database not user session for examole if user
  // update his name then we get updated name from supabase database or any other information.
  // and it is of type Future<UserModel?> mean it return UserModel or null. because if user is not log in then it return null.
  Future<UserModel?> getCurrentUserData();

  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  // It give us the user session mean user id and emil not name mean not supabase database information
  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  // I explain what is happening in this function in the AuthRepositoryImpl file
  // in getCurrentUserData function. first we check if user is log in or not
  //mean the session is null or not. if session is not null mean user is log in
  // then we get user information from supabase database and return UserModel.
  //if user is not log in then we return null.
  //if user is log in then we get user information from supabase database
  // and return UserModel. if user is not log in then we return null.
  // and it is of type Future<UserModel?> mean it return UserModel or null.
  // in the .from we pass the table name in which we want to get the data.
  // in the .select we pass the column name which we want to get.empty mean all columns.
  // in the .eq we pass the column name and value which we want to get.
  //the column name is id and value is currentUserSession!.user.id mean user id.
  // From this funtion we get the user information from supabase database.
  //not from supabase authentication.
  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(
          userData.first,
        ).copyWith(email: currentUserSession!.user.email);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // print('✅ signUpWithEmailAndPassword called');
      // print('📧 Email: $email');
      // print('🔑 Password: $password');

      final AuthResponse res = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (res.user == null) {
        throw ServerException('User is null!');
      }

      return UserModel.fromJson(res.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // print('✅ logInWithEmailAndPassword called');
      // print('📧 Email: $email');
      // print('🔑 Password: $password');

      final AuthResponse res = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.user == null) {
        throw ServerException('User is null!');
      }

      return UserModel.fromJson(res.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
