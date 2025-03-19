part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignedUpButonPressed extends AuthEvent {
  final String name;
  final String email;
  final String password;
  SignedUpButonPressed({
    required this.name,
    required this.email,
    required this.password,
  });
}

final class LogedInButonPressed extends AuthEvent {
  final String email;
  final String password;
  LogedInButonPressed({required this.email, required this.password});
}

final class AuthIsUserLoggedIn extends AuthEvent {}
