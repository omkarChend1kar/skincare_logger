import 'package:flutter/material.dart';

class AuthenticationLoadingWidgetPage extends StatelessWidget {
  static const String route = '/loadingPage';
  const AuthenticationLoadingWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: colorScheme.primary,
        color: colorScheme.secondary,
      ),
    );
  }
}
