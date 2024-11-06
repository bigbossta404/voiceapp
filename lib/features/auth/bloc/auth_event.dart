part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogin(this.email, this.password);
}

class AuthEventCreate extends AuthEvent {
  final String email;
  final String password;
  final String repassword;
  const AuthEventCreate(this.email, this.password, this.repassword);
}

class AuthEventLogout extends AuthEvent {}
