import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notjust_hack/commons/providers/fire_auth_provider.dart';
import 'package:notjust_hack/commons/providers/user_data_provider.dart';
import 'package:notjust_hack/feature/authentication/view/register_options_view.dart';
import 'package:notjust_hack/feature/authentication/view/widgets/login_form.dart';
import 'package:notjust_hack/feature/business/view/businessHome.dart';
import 'package:notjust_hack/feature/user/userNav.dart';

import '../../../res/strings.dart';
import '../../../utils/logger.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  static const routePath = "/login";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<LoginView> {
  @override
  Widget build(BuildContext context) {
    //final userId = ref.watch(userIdProvider);
    ref.listen(userDataProvider, (previous, next) {
      if (next.value != null) {
        if (next.value!.type == "user") {
          GoRouter.of(context).pushReplacement(UserNav.routePath);
        } else if (next.value!.type == "business") {
          GoRouter.of(context).pushReplacement(BusinessHome.routePath);
        }
      }
    });
    ref.listen(
      userIdProvider,
      (previous, next) {
        if (next.value != null) {
          Log().info("User is logged in");
        } else {
          Log().info("User is not logged in");
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(35),
          width: double.infinity,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome to\n${AppStrings.appName}",
                      style: GoogleFonts.aleo(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const LoginForm(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: GoogleFonts.aleo(
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign up",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              GoRouter.of(context).push(RegisterOptions.routePath);
                            },
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
