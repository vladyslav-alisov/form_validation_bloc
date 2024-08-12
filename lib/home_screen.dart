import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation_bloc/bloc/auth_bloc.dart';
import 'package:form_validation_bloc/login_screen.dart';
import 'package:form_validation_bloc/widgets/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is AuthLoading) CircularProgressIndicator(),
              if (state is AuthSuccess) Text(state.uid),
              const SizedBox(height: 20),
              GradientButton(
                title: "Sign out",
                onPress: () {
                  context.read<AuthBloc>().add(
                        AuthLogoutRequested(),
                      );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
