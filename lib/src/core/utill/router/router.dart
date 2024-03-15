import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skincare_logger/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:skincare_logger/src/features/auth/presentation/pages/auth_landing_page.dart';
import 'package:skincare_logger/src/features/auth/presentation/pages/auth_onboarding_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthCreatedAccount) {
                  return const AuthLandingPage();
                }
                if (state is AuthSignedIn) {
                  return const AuthLandingPage();
                }
                if (state is AuthSignedOut) {
                  return const AuthOnboardingPage();
                }
                return const AuthOnboardingPage();
              },
            );
          },
        );
      // Add more routes here if needed
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
