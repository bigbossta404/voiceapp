import 'package:bloc/bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLogout()) {
    /// Login account
    on<AuthEventLogin>((event, emit) async {
      emit(AuthStateLoading());
      if (event.email == 'aingmaung@mail.com') {
        // await Future.delayed(const Duration(seconds: 2), () {
        emit(AuthStateLogin());
        // });
      } else {
        emit(AuthStateError('Gagal login'));
      }
      // try {
      //   // await auth.signInWithEmailAndPassword(email: event.email, password: event.password);
      // } catch (e) {
      //   var status = AuthExceptionHandler.handleException(e);
      //   emit(AuthStateError(status.toString()));
      // }
    });

    /// Create account
    // on<AuthEventCreate>((event, emit) async {
    //   try {
    //     emit(AuthStateLoading());

    //     await auth.createUserWithEmailAndPassword(
    //       email: event.email,
    //       password: event.password,
    //     );
    //     emit(const AuthStateCreate('Create Account Successfuly'));
    //   } catch (e) {
    //     var status = AuthExceptionHandler.handleException(e);
    //     emit(AuthStateError(status.toString()));
    //   }
    // });

    on<AuthEventLogout>((event, emit) async {
      emit(AuthStateLoading());
      await Future.delayed(Duration(seconds: 2), () {
        emit(AuthStateLogout());
      });
      // try {
      //   emit(AuthStateLoading());
      //   await auth.signOut();
      //   emit(AuthStateLogout());
      // } catch (e) {
      //   var status = AuthExceptionHandler.handleException(e);
      //   emit(AuthStateError(status.toString()));
      // }
    });
  }
}
