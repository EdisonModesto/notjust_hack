import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notjust_hack/feature/authentication/view/auth_view.dart';
import 'package:notjust_hack/feature/user/1.%20discover/view/screens/discoverDetails.dart';
import 'package:notjust_hack/feature/user/userNav.dart';

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
    GoRoute(
      path: UserNav.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const UserNav();
      },
    ),
    GoRoute(
      path: DiscoverDetails.routePath,
      name: "discoverDetails",
      builder: (BuildContext context, GoRouterState state) {
        return DiscoverDetails(
          imageUrl: state.pathParameters['imageUrl'] ?? '',
        );
      },
    ),
  ],
);
