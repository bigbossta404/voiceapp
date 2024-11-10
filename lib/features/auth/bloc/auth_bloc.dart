import 'package:bloc/bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLogout()) {
    /// Login account
    on<AuthEventLogin>((event, emit) async {
      emit(AuthStateLoading());
      if (event.email == 'aingmaung@mail.com') {
        emit(AuthStateLogin());
      } else {
        emit(AuthStateError('Gagal login'));
      }
    });

    // Logout account
    on<AuthEventLogout>((event, emit) async {
      emit(AuthStateLoading());
      await Future.delayed(Duration(seconds: 2), () {
        emit(AuthStateLogout());
      });
    });
  }
}
