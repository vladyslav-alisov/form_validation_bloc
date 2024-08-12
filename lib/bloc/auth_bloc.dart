import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_handleAuthLoginRequested);
    on<AuthLogoutRequested>(_handleAuthLogoutRequested);
  }

  void _handleAuthLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final email = event.email;
      final password = event.password;

      if (password.length < 6) {
        emit(AuthFailure("Password should be more then 6 characters"));
        return;
      }
      await Future.delayed(
        const Duration(seconds: 1),
        () => emit(
          AuthSuccess('$email-$password'),
        ),
      );
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _handleAuthLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 1), () {
        return emit(AuthInitial());
      });
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  @override
  void onEvent(AuthEvent event) {
    debugPrint("Event $event");
    super.onEvent(event);
  }
}
