part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

// Login State
class AuthStateLogin extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateLogout extends AuthState {}

// Create Account State
class AuthStateCreate extends AuthState {
  final String? message;
  const AuthStateCreate(this.message);
}

class AuthStateError extends AuthState {
  final String? errorHandler;
  const AuthStateError(this.errorHandler);
}
