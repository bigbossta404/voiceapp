part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;
  AuthEventLogin(this.email, this.password);
}

class AuthEventCreate extends AuthEvent {
  final String email;
  final String password;
  final String repassword;
  AuthEventCreate(this.email, this.password, this.repassword);
}

class AuthEventLogout extends AuthEvent {}
