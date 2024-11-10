part of 'auth_bloc.dart';

abstract class AuthState {}

// Login State
class AuthStateLogin extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateLogout extends AuthState {}

// Create Account State
class AuthStateCreate extends AuthState {
  final String? message;
  AuthStateCreate(this.message);
}

class AuthStateError extends AuthState {
  final String? errorHandler;
  AuthStateError(this.errorHandler);
}
