import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notjust_hack/commons/views/screens/MapView.dart';
import 'package:notjust_hack/feature/authentication/view/login_view.dart';
import 'package:notjust_hack/feature/authentication/view/register_options_view.dart';
import 'package:notjust_hack/feature/authentication/view/register_view.dart';
import 'package:notjust_hack/feature/business/view/businessHome.dart';
import 'package:notjust_hack/feature/user/1.%20discover/view/screens/discoverDetails.dart';
import 'package:notjust_hack/feature/user/2.%20events/view/screens/addEvents.dart';
import 'package:notjust_hack/feature/user/2.%20events/view/screens/eventsDetails.dart';
import 'package:notjust_hack/feature/user/3.%20scanner/view/userScanner.dart';
import 'package:notjust_hack/feature/user/userNav.dart';

final GoRouter router = GoRouter(
  initialLocation: LoginView.routePath,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: LoginView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginView();
      },
    ),
    GoRoute(
      path: RegisterView.routePath,
      name: "register",
      builder: (BuildContext context, GoRouterState state) {
        return RegisterView(
          type: state.pathParameters['type'] ?? '',
        );
      },
    ),
    GoRoute(
      path: RegisterOptions.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterOptions();
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
          id: state.pathParameters['id'] ?? '',
        );
      },
    ),
    GoRoute(
      path: UserScanner.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const UserScanner();
      },
    ),
    GoRoute(
      path: MapView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const MapView();
      },
    ),
    GoRoute(
      path: BusinessHome.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const BusinessHome();
      },
    ),
    GoRoute(
      path: AddEvents.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const AddEvents();
      },
    ),
    GoRoute(
      path: EventsDetail.routePath,
      name: "eventDetails",
      builder: (BuildContext context, GoRouterState state) {
        return EventsDetail(
          id: state.pathParameters['id'] ?? '',
        );
      },
    ),
  ],
);
