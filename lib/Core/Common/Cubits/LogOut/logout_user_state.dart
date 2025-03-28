part of 'logout_user_cubit.dart';

@immutable
sealed class LogoutUserState {}

final class LogoutUserInitial extends LogoutUserState {}

final class LogOutUserLoading extends LogoutUserState {}

final class LogOutUserSuccess extends LogoutUserState {}
