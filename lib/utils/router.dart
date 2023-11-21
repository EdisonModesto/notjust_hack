import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notjust_hack/feature/authentication/view/auth_view.dart';

final GoRouter router = GoRouter(
  initialLocation: AuthView.routePath,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AuthView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthView();
      },
    ),
  ],
);
